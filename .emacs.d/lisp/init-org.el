;; when capturing new notes, place them in notes.org sub orgfile in org-directory
(setq org-directory "~/notes/")
(setq org-default-notes-file (concat org-directory "/scratch.org"))

;; set up capture templates -- what do I need?
;; TODOs -> TODO.org
;; ideas -> ideas.org
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/notes/TODO.org" "Tasks")
             "* TODO %?\n  %i\n  %a")
        ("n" "Notebook Entry" entry (file+datetree "~/notes/labnotebook.org")
	 )
	))

;; make other files available as refile targets (I think?))
(setq org-refile-targets '(
   (nil :maxlevel . 10)             ; refile to headings in the current buffer
   (org-agenda-files :maxlevel . 10) ; refile to any of these files
    ))
(setq org-refile-allow-creating-parent-nodes (quote confirm)) ; create new node in existing file in refile
(setq org-refile-use-outline-path 'file) ; this should allow refiling to a new file

;; org-mode shortcuts from manual
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cc" 'org-capture)
(define-key global-map "\C-cb" 'org-iswitchb)

;; log time when TODO marked done
(setq org-log-done 'time)

;; Enter to follow links (or mouse click)
(setq org-return-follows-link t)

(provide 'init-org)
