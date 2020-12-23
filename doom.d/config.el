;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(use-package! conda
  :ensure t
  :init
  (setq conda-anaconda-home (expand-file-name "/opt/miniconda3"))
  )

(setq doom-theme 'doom-city-lights)

(setq shell-file-name "xonsh")


(after! org
  (add-to-list 'org-capture-templates
             '("b" "Bill" table-line (file+headline "~/mnt/bills/bills.org" "Bills")
               "| %? | %a | | |")))

(add-to-list 'display-buffer-alist
             '("\\.pdf\\(<[^>]+>\\)?$"
               (display-buffer-in-side-window)
               (side . right)
               (window-width . 400)
               ))
