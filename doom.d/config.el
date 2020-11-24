;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(use-package! conda
  :ensure t
  :init
  (setq conda-anaconda-home (expand-file-name "/opt/miniconda3"))
  )

(setq doom-theme 'doom-city-lights)

(setq shell-file-name "xonsh")
