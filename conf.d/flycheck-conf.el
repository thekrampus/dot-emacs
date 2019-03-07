;;; Flycheck mode configuration
;;; Code:

(defun flycheck-mode-hook-definition ()
  (define-key flycheck-mode-map flycheck-keymap-prefix nil)
  (setq flycheck-keymap-prefix (kbd "M-f"))
  (define-key flycheck-mode-map flycheck-keymap-prefix flycheck-command-map))
(add-hook 'flycheck-mode-hook 'flycheck-mode-hook-definition)
(add-hook 'after-init-hook 'global-flycheck-mode)

(provide 'flycheck-conf)
