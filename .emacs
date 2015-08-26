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

(setenv "PYTHONPATH" "/home/gil/anaconda/bin/python")

(load-theme 'misterioso)

;; when capturing new notes, place them in notes.org sub orgfile in org-directory
(setq org-directory "~/Dropbox/notes/")
(setq org-default-notes-file (concat org-directory "/scratch.org"))
(define-key global-map "\C-cc" 'org-capture)

;; set up capture templates -- what do I need?
;; TODOs -> TODO.org
;; ideas -> ideas.org
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/Dropbox/notes/TODO.org" "Tasks")
             "* TODO %?\n  %i\n  %a")
        ("n" "Notebook Entry" entry (file+datetree "~/Dropbox/notes/labnotebook.org")
	 )
	))

;; make other files available as refile targets (I think?))
(setq org-refile-targets '(
   (nil :maxlevel . 2)             ; refile to headings in the current buffer
   (org-agenda-files :maxlevel . 2) ; refile to any of these files
    ))

;; ipython kernel
(require 'ob-ipython)

;; appearance shit
;;(setq line-number-mode t)
(require 'linum)
(global-linum-mode 1)

;; wrap lines by default
(visual-line-mode 1)

;; load python and gnu calc so it can be run inline
(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (python . t)
   (calc . t)
   (ipython . t)
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
(setq backup-inhibited t)
(setq auto-save-default nil)

;; powerline
(require 'powerline-evil)
(powerline-evil-vim-color-theme)
(display-time-mode t)

;;(defun insert-current-date () (interactive)
;;    (insert (shell-command-to-string "echo -n $(date +%Y-%m-%d)")))

;; yasnippet for template help
(require 'yasnippet)
(yas-global-mode 1)

;; fix some org-mode + yasnippet conflicts:
(defun yas/org-very-safe-expand ()
  (let ((yas/fallback-behavior 'return-nil)) (yas/expand)))

(add-hook 'org-mode-hook
          (lambda ()
            (make-variable-buffer-local 'yas/trigger-key)
            (setq yas/trigger-key [tab])
            (add-to-list 'org-tab-first-hook 'yas/org-very-safe-expand)
            (define-key yas/keymap [tab] 'yas/next-field)))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(org-agenda-files
   (quote
    ("~/Dropbox/notes/research.past.and.present.org" "~/Dropbox/notes/numericalmooc.org" "~/Dropbox/notes/CFDPython.org" "~/Dropbox/notes/main.org" "~/Dropbox/notes/labnotebook.org")))
 '(org-refile-targets
   (quote
    ((nil :maxlevel . 5)
     (org-agenda-files :maxlevel . 5))))
 '(org-refile-use-outline-path (quote file))
 '(org-startup-indented t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
