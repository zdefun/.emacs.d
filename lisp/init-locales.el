

(defun sanityinc/utf8-locale-p (v)
  "Return whether locale string V relates to a UTF-8 locale."
  (and v (string-match "UTF-8" v)))

(defun sanityinc/locale-is-utf8-p ()
  "Return t iff the \"locale\" command or environment variables prefer UTF-8."
  (or (sanityinc/utf8-locale-p (and (executable-find "locale") (shell-command-to-string "locale")))
      (sanityinc/utf8-locale-p (getenv "LC_ALL"))
      (sanityinc/utf8-locale-p (getenv "LC_CTYPE"))
      (sanityinc/utf8-locale-p (getenv "LANG"))))

(when (or window-system (sanityinc/locale-is-utf8-p))
  (set-language-environment (if (eq system-type 'windows-nt)  'Chinese-GB 'utf-8))
  (setq locale-coding-system (if (eq system-type 'windows-nt)  'gbk 'utf-8))
  ;;(set-default-coding-systems 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (set-selection-coding-system 'utf-8)
  (set-clipboard-coding-system (if (eq system-type 'windows-nt)  'gbk 'utf-8))
  ;;(prefer-coding-system 'utf-8)
  (setq default-buffer-file-coding-system 'utf-8)
  (setq system-time-locale "C"))
  

(provide 'init-locales)
