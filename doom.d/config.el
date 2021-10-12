;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(use-package! conda
  :ensure t
  :init
  (setq conda-anaconda-home (expand-file-name "/opt/miniconda3"))
  )

(setq doom-theme 'doom-gruvbox)

(setq shell-file-name "xonsh")


(after! org
  (setq org-log-done 'time) ;; add timestamp when task is done
  (add-to-list 'org-capture-templates
             '("b" "Bill" entry (file+olp+datetree "~/mnt/bills/bills.org" "Bills")
               "* %? %a "))
  ;; swap tilda for backtick in org mode
  (defun swap-tilda-backtick ()
    (interactive)
    (insert "~"))
  (define-key org-mode-map (kbd "`") 'swap-tilda-backtick)

(add-to-list 'display-buffer-alist
             '("\\.pdf\\(<[^>]+>\\)?$"
               (display-buffer-in-side-window)
               (side . right)
               (window-width . 400)
               )))

;; Disable flycheck noise since it's obnoxious
(use-package! flycheck
  :config
  (setq-default flycheck-disabled-checkers '(python-mypy python-pylint python-pycompile python-pyright )))

;; Fix smartparens behavior with python f-strings
(after! smartparens
  (sp-local-pair '(python-mode) "f\"" "\"")
  (sp-local-pair '(python-mode) "f'" "'"))
