;; Set up git in EMACS
(use-package magit
             :ensure magit)

;; disable backup files (that's what git is for)
(setq make-backup-files nil)
(setq backup-inhibited t)
(setq auto-save-default nil)

(global-set-key (kbd "C-M-s") 'magit-status)

(provide 'init-magit)
