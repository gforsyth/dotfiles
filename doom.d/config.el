;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(use-package! conda
  :ensure t
  :init
  (setq conda-anaconda-home (expand-file-name "/opt/miniconda3"))
  )
