;;org-mode theme
(require-package 'leuven-theme)			 
(load-theme 'leuven t)	

;;(require-package 'spacemacs-theme)			 
;;(load-theme 'spacemacs-light t)


;; 避免受字体放大或缩小影响
;;(set-face-attribute 'linum nil :font "新宋体-12")
;;状态栏
(require-package 'spaceline)
(require 'spaceline-config)
(spaceline-spacemacs-theme)
(provide 'init-themes)
