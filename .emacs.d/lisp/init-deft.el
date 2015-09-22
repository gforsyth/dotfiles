;; set up deft (note searching)
(use-package deft
             :ensure deft)
(setq deft-directory "~/Dropbox/notes")
(setq deft-use-filename-as-title t)
(setq deft-extension "org")
(setq deft-text-mode 'org-mode)

(provide 'init-deft)
