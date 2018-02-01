;;设置emacs默认打开路径
(setq default-directory "~/note")
(setq zdefun-default-directory "~/note")
(setq zdefun-workjob-directory (concat zdefun-default-directory "/work/workjob.org"))
(setq zdefun-myjob-directory (concat zdefun-default-directory "/my/myjob.org"))

;; org 个人设置
;;(setq zdefun-org-refile-files
;;      (list   (concat zdefun-default-directory "/work/workjob.org") ))
;;(setq org-refile-targets '( (zdefun-org-refile-files  :maxlevel . 1)))

(setq org-agenda-files (list  (concat zdefun-default-directory "/work/workjob.org") 
                              (concat zdefun-default-directory "/my/myjob.org")))
;;(setq zworkjob-attach-dir (concat "D:\\zhangl\\desktop\\work\\" (format-time-string "%Y\\")))
;;华润工作目录
(setq zworkjob-attach-dir "D:\\crbworkdata\\项目管理\\重要事项\\")
(setq zmyjob-attach-dir (concat "D:\\zhangl\\desktop\\my\\" (format-time-string "%Y\\")))

(defun zmyjob-templates()
  (let ((time-string (format-time-string "%Y%m%d%H%M")))
    (concat "* TODO " time-string "-%?\n  :PROPERTIES:\n  :ATTACH_DIR: " zmyjob-attach-dir
            "\n  :ATTACH_DIR_INHERIT: t" "\n  :END:\n  任务日期：%T\n")))
(defun zworkjob-templates()
  (let ((time-string (format-time-string "%Y%m%d%H%M")))
    (concat "* TODO " time-string "-%?\n  :PROPERTIES:\n  :ATTACH_DIR: " zworkjob-attach-dir
            "\n  :ATTACH_DIR_INHERIT: t" "\n  :END:\n  任务日期：%T\n")))

;;(setq org-capture-templates
;;      `(("w" "workjob" entry (file+headline zdefun-workjob-directory "workjob")  ; "" => org-default-notes-file
;;         "* TODO %T%? " :clock-resume t)
;;        ("m" "myjob" entry (file+headline zdefun-myjob-directory "myjob")  ; "" => org-default-notes-file
;;         "* TODO %T%? \n" :clock-resume t)
;;        ))
(setq org-capture-templates `(("w" "workjob" entry (file+headline zdefun-workjob-directory
                                                                  "workjob") ; "" => org-default-notes-file
                               (function zworkjob-templates) 
                               :clock-resume t) 
                              ("m" "myjob" entry (file+headline zdefun-myjob-directory "myjob") ; "" => org-default-notes-file
                               (function zmyjob-templates) 
                               :clock-resume t)))

;; 任务捕捉
;;(defun z-org-capture-prepare-finalize-hook()
;;(insert "\n  :PROPERTIES:\n  :ATTACH_DIR: D:\\zhangl\\zdesktop\\\n  :END:"))
;;(add-hook 'org-capture-prepare-finalize-hook 'z-org-capture-prepare-finalize-hook)

;;
(setq org-directory "~/note")

;; linux拼音
;;(if (not (eq system-type 'windows-nt)) (require 'init-pyim))
;;(require 'init-pyim)

;; bing字典
;;(require-package 'bing-dict)
;;(global-set-key (kbd "C-c d") 'bing-dict-brief)
;;(setq bing-dict-show-thesaurus 'both)
;;(setq bing-dict-save-search-result t)
;;(setq bing-dict-org-file  (concat zdefun-default-directory "/collect/zvocabulary.org"))
;; 显示时间，格式如下
;;(display-time-mode 1)
;;(setq display-time-24hr-format t)
;;(setq display-time-day-and-date t)


;;(require-package 'yasnippet)
;;(yas-global-mode 1)

;;tetris游戏设置
;;(require 'tetris)
;;(defun tetris-my-update-speed-function (_shapes rows)
;;  (/ 20.0 (+ 50.0 50 rows)))
;;
;;(setq tetris-update-speed-function
;;             'tetris-my-update-speed-function)

;;去除TAB
(setq-default indent-tabs-mode nil)
;;自动换行
(defun ztl-switch-truncate-line()
  (interactive)
  ( if (> (frame-parameter (selected-frame) 'width) 95)
      (let ()
        (toggle-truncate-lines t)
        (horizontal-scroll-bar-mode t))
    (let ()
      (toggle-truncate-lines -1)
      (horizontal-scroll-bar-mode -1)))
  )

(global-set-key (kbd "C-x t") 'ztl-switch-truncate-line)
(defalias 'ztt-toggle-truncate-lines 'toggle-truncate-lines)

(require 'init-zdefun)

(provide 'init-custom)
