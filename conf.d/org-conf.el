;;; Org mode configuration
;;; Code:

(defun org-mode-hook-definition ()
  (autopair-mode -1)
  (fci-mode)
  (defun make-page-number (string)
    (if (= (length string) 0)
        ""
      (concat "::" string))))
(add-hook 'org-mode-hook 'org-mode-hook-definition)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-agenda-files
      (quote
       ("~/org/")))
(setq org-file-apps
      '((auto-mode . emacs)
        ("\\.x?html?\\'" . "chromium %s")
        ("\\.pptx?\\'" . "libreoffice %s")
        ("\\.docx?\\'" . "libreoffice %s")
        ("\\.pdf\\'" . "evince \"%s\"")
        ("\\.pdf::\\([0-9]+\\)\\'" . "evince \"%s\" -p %1")))
(setq org-hide-emphasis-markers t)
(setq org-log-done t)

(provide 'org-conf)
