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

(add-to-list 'display-buffer-alist
             '("\\.pdf\\(<[^>]+>\\)?$"
               (display-buffer-in-side-window)
               (side . right)
               (window-width . 400)
               )))
