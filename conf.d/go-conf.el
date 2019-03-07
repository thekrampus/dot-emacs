;;; Go language mode configuration
;;; Code:

(defun go-mode-hook-definition ()
  (column-enforce-mode 1)
  (auto-complete-mode 1)
  (add-hook 'before-save-hook 'gofmt-before-save)
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go build -v; and go test -v; and go vet"))
  (local-set-key (kbd "M-.") 'godef-jump)
  (local-set-key (kbd "C-c C-c") 'compile)
  (local-set-key (kbd "M-RET") 'go-run))
(add-hook 'go-mode-hook 'go-mode-hook-definition)
(with-eval-after-load 'go-mode
  (require 'go-autocomplete)
  (require 'go-guru))

(provide 'go-conf)
