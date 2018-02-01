;; save a list of open files in ~/.emacs.d/.emacs.desktop
(setq desktop-path (list user-emacs-directory)
      desktop-auto-save-timeout 600)
(desktop-save-mode 1)

(defadvice desktop-read (around time-restore activate)
    (let ((start-time (current-time)))
      (prog1
          ad-do-it
        (message "Desktop restored in %.2fms"
                 (sanityinc/time-subtract-millis (current-time)
                                                 start-time)))))

(defadvice desktop-create-buffer (around time-create activate)
  (let ((start-time (current-time))
        (filename (ad-get-arg 1)))
    (prog1
        ad-do-it
      (message "Desktop: %.2fms to restore %s"
               (sanityinc/time-subtract-millis (current-time)
                                               start-time)
               (when filename
       (abbreviate-file-name filename))))))

;;----------------------------------------------------------------------------
;; Restore histories and registers after saving
;;----------------------------------------------------------------------------
;;(setq-default history-length 10)
;;(savehist-mode t)
;; save a bunch of variables to the desktop file
;; for lists specify the len of the maximal saved data also
;;(setq desktop-globals-to-save
;;      (append '(
;;                (extended-command-history . 30)
;;                (file-name-history        . 100)
;;                (helm-find-files-history  . 100)
;;                (org-refile-history       . 50)
;;)))

(provide 'init-sessions)
