;;(require-package 'org-plus-contrib)
;;(require-package 'htmlize)
;;中文断行： zwz，作者声明只适应 org-mode 8.0 以及以上版本
(require 'ox)
(defun clear-single-linebreak-in-cjk-string (string)
  "clear single line-break between cjk characters that is usually soft line-breaks"
  (let* ((regexp "\\([\u4E00-\u9FA5]\\)\n\\([\u4E00-\u9FA5]\\)")
         (start (string-match regexp string)))
    (while start
      (setq string (replace-match "\\1\\2" nil nil string)
            start (string-match regexp string start))))
  string)

(defun ox-html-clear-single-linebreak-for-cjk (string backend info)
  (when (org-export-derived-backend-p backend 'html)
    (clear-single-linebreak-in-cjk-string string)))

(add-to-list 'org-export-filter-final-output-functions
             'ox-html-clear-single-linebreak-for-cjk)

			 
;;设置所有的.org 打开默认为 utf-8
(modify-coding-system-alist 'file "\\.org\\'" 'utf-8)

;; 自动换行
(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))


;; 自动缩进
;;(setq org-startup-indented t)

;; 自动捕捉任务
(global-set-key (kbd "C-c c") 'org-capture)

;;c-c a 添加自定义命令
(setq org-agenda-custom-commands
      '(("w" "Weekly Review" agenda ""
         ((org-agenda-ndays 7)                          ;; [1]
          (org-agenda-start-on-weekday 0)               ;; [2]
          (org-agenda-time-grid nil)
          (org-agenda-repeating-timestamp-show-all t)   ;; [3]
          (org-agenda-entry-types '(:timestamp :sexp))))  ;; [4]
        ;; other commands go here
        ))
;;发布html
;;(setq org-publish-project-alist
;;      '(
;;        ;; ... add all the components here (see below)...
;;        ("org-notes"
;;         :base-directory "d:/zliang/worknote"      ;org文件的目录
;;         :base-extension "org"                     ;扩展名
;;         :publishing-directory "d:/zliang/publish" ;导出目录
;;         ;;:html-head "<link rel=\"stylesheet\" type=\"text/css\" href=\"./css/org-css.css\"/>";自定义样式
;;         :recursive t
;;         :publishing-function org-html-publish-to-html
;;         :headline-levels 4       ; Just the default for this project.
;;         :auto-preamble t
;;         :auto-sitemap t
;;         :timestamp nil
;;         :table-of-contents t
;;         :author nil
;;         )
;;        ("org" :components ("org-notes"))
;;        ))

(setq org-html-validation-link nil) ; 去掉validation显示
;;(setq org-html-link-home "index.html"); 设置home超链接
;;(setq org-html-link-up "index.html")
(setq org-support-shift-select t)
;;设置 org导出默认为zh-CN
(setq org-export-default-language "zh-CN")

(when (or (eq system-type 'cygwin) (eq system-type 'windows-nt))
  ;;org-mode时打开文件时默认win系统打开
  (setq org-file-apps '())
  )
(add-to-list 'org-file-apps '("\\.org\\'" . emacs))
(defun org-zdefun-default-apps ()
  "Return the default applications for this operating system."
  (cond
   ((eq system-type 'darwin)
    org-file-apps-defaults-macosx)
   ((or (eq system-type 'windows-nt) (eq system-type 'cygwin))
    org-file-apps-defaults-windowsnt)
   (t org-file-apps-defaults-gnu)))
;;(require 'org)
(setq  org-default-apps
             'org-zdefun-default-apps)

;;所有 org 文件不转义 _ 字符
(setq org-export-with-sub-superscripts nil)
;;所有 org 文件不转义特殊字符
(setq org-export-with-special-strings nil)
;;不导出todo关键字
;;(setq org-export-with-todo-keywords nil)
;;设置作者
;;(setq org-export-with-author "zdefun")
;;设置作者邮箱
;;(setq org-export-with-email 'zdefun@gmail.com)
;;使用换行符
(setq org-export-preserve-breaks t)
;;设置120列换行
;;(setq-default fill-column 120)
;;避免 * 数字需要换行
;;导出目录层级
;;(setq org-export-headline-levels 2)

(setq org-export-preserve-breaks t)
;; org-info-js样式
;;(defconst zdefun-org-html-scripts
;;  "<link rel=\"stylesheet\" type=\"text/css\" href=\"org-info-js/stylesheet.css\" />
;;<script type=\"text/javascript\" src=\"org-info-js/org-info.js\"></script>
;;<script type=\"text/javascript\" >
;;<!--/*--><![CDATA[/*><!--*/
;;org_html_manager.set(\"TOC_DEPTH\", \"4\");
;;org_html_manager.set(\"LOCAL_TOC\", \"1\");
;;org_html_manager.set(\"VIEW_BUTTONS\", \"0\");
;;org_html_manager.set(\"MOUSE_HINT\", \"underline\");
;;org_html_manager.set(\"FIXED_TOC\", \"0\");
;;org_html_manager.set(\"VIEW\", \"showall\");
;;org_html_manager.set(\"TOC\", \"1\");
;;org_html_manager.setup();  // activate after the parameters are set
;;/*]]>*///-->
;;</script>")
(setq org-html-style-default nil)
;;(setq org-html-scripts zdefun-org-html-scripts )
(setq org-html-mathjax-template "")
;;#+BEGIN_SRC calc
;;1+23
;;#+END_SRC
;;c-c c-c 会计算结果
(setq org-confirm-babel-evaluate nil)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (calc . t)))
;;
(setq-default org-display-custom-times t)
(setq org-time-stamp-custom-formats '("<%Y年%m月%d日>" . "<%Y年%m月%d日 %H:%M>"))

; Set deadline warning days
(setq org-deadline-warning-days 30)

; Deadline headers
(setq org-agenda-deadline-leaders '("今天截止:" "还有 %2d 天:" "%2d 天以前:"))
(setq org-agenda-scheduled-leaders '("已安排:" "计划已过期 %d 天:"))


; Org Agenda date and time in Chinese
(require 'org-agenda)

(defalias 'org-agenda-format-date-aligned 'tommy-org-agenda-format-date-aligned)

(defun tommy-org-agenda-format-date-aligned (date)
  "Format a DATE string for display in the daily/weekly agenda, or timeline.
  This function makes sure that dates are aligned for easy reading."
  (require 'cal-iso)
  (let* ((dayname (calendar-day-name date))
    (day (cadr date))
    (day-of-week (calendar-day-of-week date))
    (month (car date))
    (monthname (calendar-month-name month))
    (year (nth 2 date))
    (iso-week (org-days-to-iso-week
      (calendar-absolute-from-gregorian date)))
      (weekyear (cond ((and (= month 1) (>= iso-week 52))
        (1- year))
        ((and (= month 12) (<= iso-week 1))
        (1+ year))
        (t year)))
    (weekstring (if (= day-of-week 1)
      (format " W%02d" iso-week)
        ""))
    (chinese-dayname '("星期日" "星期一" "星期二" "星期三" "星期四" "星期五" "星期六")))
    (format "%4d年%d月%d日 第%2d周 %s"
      year month day iso-week (nth day-of-week chinese-dayname))))

(require 'org-attach)
(defun z-org-attach-reveal (&optional if-exists)
  "Show the attachment directory of the current task.
This will attempt to use an external program to show the directory."
  (interactive "P")
  (cond ((org-entry-get nil "ATTACH_DIR") 
    (let ((attach-dir (org-attach-dir (not if-exists))))
    (and attach-dir (org-open-file attach-dir)))))
)
(defun z-org-attach ()
  "The dispatcher for attachment commands.
Shows a list of commands and prompts for another key to execute a command."
  (interactive)
  (let (c marker)
    (when (eq major-mode 'org-agenda-mode)
      (setq marker (or (get-text-property (point) 'org-hd-marker)
		       (get-text-property (point) 'org-marker)))
      (unless marker
	(error "No task in current line")))
    (save-excursion
      (when marker
	(set-buffer (marker-buffer marker))
	(goto-char marker))
      (org-back-to-heading t)
      (call-interactively 'z-org-attach-reveal))))
(global-set-key (kbd "C-f") 'z-org-attach)
(provide 'init-org)
