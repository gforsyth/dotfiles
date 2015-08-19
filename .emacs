(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

(require 'evil)
(evil-mode t)

;; prevent cursor from moving back one position when exiting insert mode
(setq evil-move-cursor-back nil)


(load-theme 'misterioso)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(org-file-apps
   (quote
    ((auto-mode . emacs)
     ("\\.mm\\'" . default)
     ("\\.x?html?\\'" . "chromium %s")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; when capturing new notes, place them in notes.org sub orgfile in org-directory
(setq org-directory "~/Dropbox/notes/")
(setq org-default-notes-file (concat org-directory "/notes.org"))
(define-key global-map "\C-cc" 'org-capture)

;; appearance shit
(setq line-number-mode t)
(require 'linum)
(linum-mode t)

;; load python and gnu calc so it can be run inline
(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (python . t)
   (calc . t)
   )
 )

;; disable evaluation security (just run the damn thing)
(setq org-confirm-babel-evaluate nil)

;; Enter to follow links (or mouse click)
(setq org-return-follows-link t)

;;(setq org-completion-use-ido t)
(auto-complete-mode t)

(icomplete-mode 1)

(require 'helm)
(require 'helm-config)
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to do persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

;; Set up git in EMACS
(require 'git)

;; disable backup files (that's what git is for)
(setq make-backup-files nil)

;; powerline
(require 'powerline-evil)
(powerline-evil-vim-color-theme)
(display-time-mode t)
