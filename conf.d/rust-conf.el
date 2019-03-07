;;; Rust mode configuration
;;; Code:

(defun rust-run-buffer ()
  (interactive)
  (compile "cargo run -v" t))
(defun rust-mode-hook-definition ()
  (column-enforce-mode 1)
  (setq column-enforce-column 100)
  ;; (auto-complete-mode 1)
  (rust-enable-format-on-save)
  (racer-mode)
  ;; (company-mode)
  (if (not (string-match "cargo" compile-command))
      (set (make-local-variable 'compile-command)
           "cargo build -v"))
  (local-set-key (kbd "C-c C-c") 'compile)
  (local-set-key (kbd "M-RET") 'rust-run-buffer))
(defun racer-mode-hook-definition()
  (setq racer-rust-src-path (getenv "RUST_SRC_PATH"))
  (eldoc-mode)
  (company-mode)
  (setq company-tooltip-align-annotations t)
  (local-set-key (kbd "TAB") #'company-indent-or-complete-common))
(add-hook 'rust-mode-hook 'rust-mode-hook-definition)
(add-hook 'flycheck-mode-hook 'flycheck-rust-setup)
(add-hook 'racer-mode-hook 'racer-mode-hook-definition)
(require 'company-racer)
  (with-eval-after-load 'company
    (add-to-list 'company-backends 'company-racer))

(provide 'rust-conf)
