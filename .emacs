(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

;; autoinstall packages if not found
;; (defvar gforsyth/packages '(evil
;; 			    ob-ipython
;; 			    linum
;; 			    helm
;; 			    deft
;; 			    yasnippet)
;;   "Default packages")
;; 
;; ;; from aaronbedra.com/emacs.d
;; (defun gforsyth/packages-installed-p ()
;;   (loop for pkg in gforsyth/packages
;;         when (not (package-installed-p pkg)) do (return nil)
;;         finally (return t)))
;; 
;; (unless (gforsyth/packages-installed-p)
;;   (message "%s" "Refreshing package database...")
;;   (package-refresh-contents)
;;   (dolist (pkg gforsyth/packages)
;;     (when (not (package-installed-p pkg))
;;       (package-install pkg))))
 
			    

;; Turn off scroll bar and toolbar
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; disable tabs
(setq tab-width 4
      indent-tabs-mode nil)

;; can't learn vim AND emacs, can I?
(require 'evil)
(evil-mode t)

;; prevent cursor from moving back one position when exiting insert mode
(setq evil-move-cursor-back nil)

;; automagically reload buffers when they're changed on disk
(global-auto-revert-mode t)

;; when you have energy, check to see if this matters
(setenv "PYTHONPATH" "/home/gil/anaconda/bin/python")

(load-theme 'misterioso)

;; set default directory to dropbox
(setq default-directory "/home/gil/Dropbox/notes/")

;; when capturing new notes, place them in notes.org sub orgfile in org-directory
(setq org-directory "~/Dropbox/notes/")
(setq org-default-notes-file (concat org-directory "/scratch.org"))

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

;; org-mode shortcuts from manual
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cc" 'org-capture)
(define-key global-map "\C-cb" 'org-iswitchb)

;; log time when TODO marked done
(setq org-log-done 'time)

;; ipython kernel
(require 'ob-ipython)

;; appearance shit
;;(setq line-number-mode t)
(require 'linum)
(global-linum-mode 1)

;; wrap lines by default
(global-visual-line-mode t)

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
(require 'auto-complete)
(global-auto-complete-mode t)

;(icomplete-mode 1)

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

;; markdown mode settings
(autoload 'markdown-mode "markdown-mode"
       "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; custom file handlers
(setq org-file-appls '((auto-mode . emacs)
		       ("\\.pdf\\'" . "llpp %s")))

;; i don't like typing out 'yes' or 'no'
(defalias 'yes-or-no-p 'y-or-n-p)

;; set up deft (note searching)
(require 'deft)
(setq deft-directory "~/Dropbox/notes")
(setq deft-use-filename-as-title t)
(setq deft-extension "org")
(setq deft-text-mode 'org-mode)

;; autopair braces etc...
(require 'autopair)

;; fix latex preamble
(require 'ox-latex)

(add-to-list 'org-latex-classes
             '("myreport"
"\\documentclass[a4paper,10pt]{report}
\\usepackage[utf8]{inputenc}
\\usepackage{amsmath}
\\usepackage{amsfonts}
\\usepackage{amssymb}
\\usepackage{hyperref}
\\usepackage[left=2.5cm,right=2.5cm,top=2.5cm,bottom=2.5cm]{geometry}
\\usepackage{fontspec}
\\setmainfont{Linux Biolinum}
[NO-DEFAULT-PACKAGES]
[NO-PACKAGES]"
("\\section{%s}" . "\\section*{%s}")
           ("\\subsection{%s}" . "\\subsection*{%s}")
           ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
           ("\\paragraph{%s}" . "\\paragraph*{%s}")
           ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

;; reftex in orgmode for citing papers
;; (defun org-mode-reftex-setup ()
;;   (load-library "reftex")
;;   (and (buffer-file-name) (file-exists-p (buffer-file-name))
;;        (progn
;; 	 ;enable auto-revert-mode to update reftex when bibtex file changes on disk
;; 	 (global-auto-revert-mode t)
;; 	 (reftex-parse-all)
;; ;;	 ;add a custom reftex cite format to insert links
;; 	 (reftex-set-cite-format
;; 	  '((?b . "[[bib:%l][%l-bib]]")
;; 	    (?n . "[[notes:%l][%l-notes]]")
;; 	    (?p . "[[/home/gil/Dropbox/notes/papers/:%l][%l-paper]]")
;; 	    (?t . "%t")
;; 	    (?h . "** %t\n:PROPERTIES:\n:Custom_ID: %l\n:END:\n[[papers:%l][%l-paper]]")))))
;;   (define-key org-mode-map (kbd "C-c )") 'reftex-citation)
;;   (define-key org-mode-map (kbd "C-c (") 'org-mode-reftex-search))
;; 
;; (add-hook 'org-mode-hook 'org-mode-reftex-setup)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(org-agenda-files
   (quote
    ("~/Dropbox/notes/insectflight.org" "~/Dropbox/notes/todo.org" "~/Dropbox/notes/checkout.org" "~/Dropbox/notes/numericalmooc.org" "~/Dropbox/notes/events.org" "~/Dropbox/notes/personal.org" "~/Dropbox/notes/CFDPython.org" "~/Dropbox/notes/labnotebook.org")))
 '(org-file-apps
   (quote
    ((auto-mode . emacs)
     ("\\.mm\\'" . default)
     ("\\.x?html?\\'" . default)
     ("\\.pdf\\'" . "evince %s")
     ("\\.pdf::\\([0-9]+\\)\\'" . "evince \"%s\" -p %1"))))
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
