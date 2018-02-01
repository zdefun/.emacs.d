;;https://github.com/tumashu/pyim
;; 中文输入法
(require-package 'pyim)
(require 'pyim)
;; 拼音词库设置，五笔用户 *不需要* 此行设置
(require-package 'pyim-basedict) 
;; 拼音词库，五笔用户 *不需要* 此行设置
;; 2兆词库
;;(pyim-basedict-enable)  
;; 20兆词库
(pyim-bigdict-enable)

(setq default-input-method "pyim")
;; 我使用全拼
;;(setq pyim-default-scheme 'quanpin)
;; 使用五笔输入法
;;(setq pyim-default-scheme 'wubi)
;;(require-package 'pyim-wbdict)
;;(pyim-wbdict-gb2312-enable) ; gb2312 version
;;(pyim-wbdict-gbk-enable) ; gbk version

;; 设置 pyim 探针设置，这是 pyim 高级功能设置，可以实现 *无痛* 中英文切换 :-)
;; 我自己使用的中英文动态切换规则是：
;; 1. 光标只有在注释里面时，才可以输入中文。
;; 2. 光标前是汉字字符时，才能输入中文。
;; 3. 使用 M-j 快捷键，强制将光标前的拼音字符串转换为中文。
;;(setq-default pyim-english-input-switch-functions
;;              '(pyim-probe-dynamic-english
;;                pyim-probe-isearch-mode
;;                pyim-probe-program-mode
;;                pyim-probe-org-structure-template))

;;(setq-default pyim-punctuation-half-width-functions
;;              '(pyim-probe-punctuation-line-beginning
;;                pyim-probe-punctuation-after-punctuation))


;; 开启拼音搜索功能
;;(setq pyim-isearch-enable-pinyin-search t)

;; 使用 pupup-el 来绘制选词框
(setq pyim-page-tooltip 'popup)

;; 选词框显示5个候选词
(setq pyim-page-length 6)

;; 让 Emacs 启动时自动加载 pyim 词库
(add-hook 'emacs-startup-hook
          #'(lambda () (pyim-restart-1 t)))
;;(defun zl-pyim-restart()
;;  (interactive)
;;  (pyim-restart-1 t)
;;  )

;;:bind
;;(("M-j" . pyim-convert-code-at-point) ;与 pyim-probe-dynamic-english 配合
;; ("C-;" . pyim-delete-word-from-personal-buffer)))


(provide 'init-pyim)
