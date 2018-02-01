;;----------------------------------------------------------------------------
;; Stop C-z from minimizing windows under OS X
;;----------------------------------------------------------------------------
(defun sanityinc/maybe-suspend-frame ()
  (interactive)
  (unless (and *is-a-mac* window-system)
    (suspend-frame)))

(global-set-key (kbd "C-z") 'sanityinc/maybe-suspend-frame)


;;----------------------------------------------------------------------------
;; Suppress GUI features
;;----------------------------------------------------------------------------
(setq use-file-dialog nil)
(setq use-dialog-box nil)
(setq inhibit-startup-screen t)
(setq inhibit-startup-echo-area-message t)

;;----------------------------------------------------------------------------
;; Show a marker in the left fringe for lines not in the buffer
;;----------------------------------------------------------------------------
(setq indicate-empty-lines t)


;;----------------------------------------------------------------------------
;; Window size and features
;;----------------------------------------------------------------------------
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'set-scroll-bar-mode)
  (set-scroll-bar-mode nil))
(when (fboundp 'menu-bar-mode)
  (menu-bar-mode -1))

(let ((no-border '(internal-border-width . 0)))
  (add-to-list 'default-frame-alist no-border)
  (add-to-list 'initial-frame-alist no-border))

(defun sanityinc/adjust-opacity (frame incr)
  "Adjust the background opacity of FRAME by increment INCR."
  (unless (display-graphic-p frame)
    (error "Cannot adjust opacity of this frame"))
  (let* ((oldalpha (or (frame-parameter frame 'alpha) 100))
         ;; The 'alpha frame param became a pair at some point in
         ;; emacs 24.x, e.g. (100 100)
         (oldalpha (if (listp oldalpha) (car oldalpha) oldalpha))
         (newalpha (+ incr oldalpha)))
    (when (and (<= frame-alpha-lower-limit newalpha) (>= 100 newalpha))
      (modify-frame-parameters frame (list (cons 'alpha newalpha))))))

(when (and *is-a-mac* (fboundp 'toggle-frame-fullscreen))
  ;; Command-Option-f to toggle fullscreen mode
  ;; Hint: Customize `ns-use-native-fullscreen'
  (global-set-key (kbd "M-ƒ") 'toggle-frame-fullscreen))

;; TODO: use seethru package instead?
(global-set-key (kbd "M-C-8") (lambda () (interactive) (sanityinc/adjust-opacity nil -2)))
(global-set-key (kbd "M-C-9") (lambda () (interactive) (sanityinc/adjust-opacity nil 2)))
(global-set-key (kbd "M-C-0") (lambda () (interactive) (modify-frame-parameters nil `((alpha . 100)))))


(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))

;; Non-zero values for `line-spacing' can mess up ansi-term and co,
;; so we zero it explicitly in those cases.
(add-hook 'term-mode-hook
          (lambda ()
            (setq line-spacing 0)))


(require-package 'disable-mouse)

;; 设置字体
(add-to-list 'default-frame-alist '(font .  "YaHei Consolas Hybrid-12.0"))
(set-face-attribute 'default t :font  "YaHei Consolas Hybrid-12.0" )
;;命令交互
(fset 'yes-or-no-p 'y-or-n-p)	

(defun save-framegeometry ()
  "Gets the current frame's geometry and saves to ~/.emacs.d/framegeometry."
  (let (
        (framegeometry-left (frame-parameter (selected-frame) 'left))
        (framegeometry-top (frame-parameter (selected-frame) 'top))
        (framegeometry-width (frame-parameter (selected-frame) 'width))
        (framegeometry-height (frame-parameter (selected-frame) 'height))
        (framegeometry-file (expand-file-name "~/.emacs.d/framegeometry"))
        )

    (when (not (number-or-marker-p framegeometry-left))
      (setq framegeometry-left 0))
    (when (not (number-or-marker-p framegeometry-top))
      (setq framegeometry-top 0))
    (when (not (number-or-marker-p framegeometry-width))
      (setq framegeometry-width 0))
    (when (not (number-or-marker-p framegeometry-height))
      (setq framegeometry-height 0))

    (with-temp-buffer
      (insert
       ";;; This is the previous emacs frame's geometry.\n"
       ";;; Last generated " (current-time-string) ".\n"
       (format "(add-to-list 'default-frame-alist   '(top . %d))\n" (max framegeometry-top 0))
       (format "(add-to-list 'default-frame-alist   '(left . %d))\n" (max framegeometry-left 0))
       (format "(add-to-list 'default-frame-alist   '(width . %d))\n" (max framegeometry-width 0))
       (format "(add-to-list 'default-frame-alist   '(height . %d))\n" (max framegeometry-height 0)))
      (when (file-writable-p framegeometry-file)
        (write-file framegeometry-file))))
  )

(defun load-framegeometry ()
  "Loads ~/.emacs.d/framegeometry which should load the previous frame's geometry."
  (let ((framegeometry-file (expand-file-name "~/.emacs.d/framegeometry")))
    (when (file-readable-p framegeometry-file)
      (load-file framegeometry-file)))
  )
( if (equal (load-framegeometry) nil)
    (let ()
      ;;人性的宽度
      (add-to-list 'default-frame-alist '(width . 95))
      (add-to-list 'default-frame-alist '(height . 32))
      (add-to-list 'default-frame-alist '(top . 3))
      (add-to-list 'default-frame-alist '(left . 273)) )

  )

;;(horizontal-scroll-bar-mode t)
;;当宽度超过95，不换行，否则自动换行
;;(setq previous-frame-width 0)
;;(setq zdefun-mode-state "-1")
;;(setq window-size-change-functions
;;      '((lambda (frame)
;;          (if (or (< previous-frame-width (- (frame-width frame) 2)) (> previous-frame-width (+ (frame-width frame) 2)))
;;              (let ()
;;                (if (> (frame-width frame) 95)
;;                    (let ()
;;                      (if (not (string= zdefun-mode-state "0") )
;;                          (let ()
;;                            (toggle-truncate-lines t)
;;                            (horizontal-scroll-bar-mode t)
;;                            (setq zdefun-mode-state "0")
;;                            ))
;;                      )
;;                  (let ()
;;                    (if (not (string= zdefun-mode-state "1") )
;;                        (let ()
;;                          (toggle-truncate-lines -1)
;;                          (horizontal-scroll-bar-mode -1)
;;                          (setq zdefun-mode-state "1")
;;                          ))
;;                    ))
;;                (setq previous-frame-width (frame-width frame))
;;                )
;;            )
;;          )
;;        )
;;      )






;;设置换行的图标
(define-fringe-bitmap 'right-curly-arrow
  [#b111110000
   #b000001000
   #b000001000
   #b000001000
   #b000001000
   #b000001000
   #b000001000
   #b000001000
   #b000001000
   #b001001000
   #b011001000
   #b111110000
   #b011000000
   #b001000000])
(define-fringe-bitmap 'left-curly-arrow
  [#b000011111
   #b000100000
   #b000100000
   #b000100000
   #b000100000
   #b000100000
   #b000100000
   #b000100000
   #b000100000
   #b000100100
   #b000100110
   #b000011111
   #b000000110
   #b000000100])
;; start global show line number
;;(global-linum-mode t)



(provide 'init-gui-frames)
