;;; nXML mode configuration
;;; Code:

(defun nxml-mode-hook-definition ()
  (auto-complete-mode 1)
  (local-set-key (kbd "M-{") 'nxml-backward-element)
  (local-set-key (kbd "M-}") 'nxml-forward-element)
  (local-set-key (kbd "M-_") 'nxml-backward-up-element)
  (local-set-key (kbd "M-+") 'nxml-down-element))
(add-hook 'nxml-mode-hook 'nxml-mode-hook-definition)

(provide 'nxml-conf)
