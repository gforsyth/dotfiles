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

(provide 'init-babel)
