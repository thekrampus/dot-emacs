;;; ASM mode configuration
;;; Code:

(defun nasm-compile ()
  "Compile with nasm, default args"
  (interactive)
  (shell-command-on-region
   ;; Beginning and end of buffer
   (point-min)
   (point-max)
   ;; Command and parameters
   (format "nasm %s" (file-name-nondirectory buffer-file-name))
   ;; Get or create output buffer
   (generate-new-buffer "NASM")
   ;; Do not replace current buffer
   nil
   ;; Error buffer
   "##NASM Error Buffer##"
   ;; Show error buffer
   t ))

(add-hook 'asm-mode-hook
  (lambda ()
    (local-set-key (kbd "C-c C-c") 'nasm-compile)))

(provide 'nasm-conf)
