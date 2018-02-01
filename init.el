
;;; This file bootstraps the configuration, which is divided into
;;; a number of other files.

(let ((minver "24.1"))
  (when (version<= emacs-version minver)
    (error "Your Emacs is too old -- this config requires v%s or higher" minver)))
(when (version<= emacs-version "24.4")
  (message "Your Emacs is old, and some functionality in this config will be disabled. Please upgrade if possible."))

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(require 'init-benchmarking) ;; Measure startup time

;;(defconst *spell-check-support-enabled* nil) ;; Enable with t if you prefer
(defconst *is-a-mac* (eq system-type 'darwin))

;;----------------------------------------------------------------------------
;; Adjust garbage collection thresholds during startup, and thereafter
;;----------------------------------------------------------------------------
(setq normal-gc-cons-threshold (* 50 1024 1024))
(let ((init-gc-cons-threshold (* 128 1024 1024)))
  (setq gc-cons-threshold init-gc-cons-threshold)
  (add-hook 'after-init-hook
(lambda () (setq gc-cons-threshold normal-gc-cons-threshold))))


;;----------------------------------------------------------------------------
;; Bootstrap config
;;----------------------------------------------------------------------------
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(require 'init-utils)
(require 'init-site-lisp) ;; Must come before elpa, as it may provide package.el
;; Calls (package-initialize)
(require 'init-elpa)      ;; Machinery for installing required packages
(require 'init-exec-path) ;; Set up $PATH

;;----------------------------------------------------------------------------
;; Load configs for specific features and modes
;;----------------------------------------------------------------------------
(require 'init-locales)
;;(require 'init-cal)
(require 'init-gui-frames)
;;(require 'init-dired)
;;(require 'init-isearch)
;;(require 'init-recentf)
(require 'init-helm)

(require 'init-windows)
(require 'init-sessions)
;;(require 'init-editing-utils)
;;(when *spell-check-support-enabled*
;;  (require 'init-spelling))
(require 'init-local nil t)
;;----------------------------------------------------------------------------
;; Variables configured via the interactive 'customize' interface
;;----------------------------------------------------------------------------
(require 'init-themes)
(require 'init-org)
(require 'init-custom)
;;(when (file-exists-p custom-file)
;;  (load custom-file))

(provide 'init)


