;;; Processing mode configuration
;;; Code:

(add-to-list 'load-path "~/.emacs.d/processing-emacs/")
(autoload 'processing-mode "processing-mode" "Processing mode" t)
(add-to-list 'auto-mode-alist '("\\.pde$" . processing-mode))
(setq processing-location "/usr/bin/processing-java")

(provide 'processing-conf)
