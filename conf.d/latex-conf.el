;;; LaTeX & AUCTeX configuration
;;; Code:

(if (file-exists-p "auctex.el")
    ((load "auctex.el" nil t t)
     (setq TeX-auto-save t)
     (setq TeX-parse-self t)
     (setq TeX-save-query nil)
     (setq TeX-PDF-mode t)))
(if (file-exists-p "preview-latex.el")
    ((load "preview-latex.el" nil t t)))

;; LaTeX hooks (not AUCTeX specific)
(defun turn-on-outline-minor-mode ()
  (outline-minor-mode 1))
(add-hook 'LaTeX-mode-hook 'turn-on-outline-minor-mode)
(add-hook 'latex-mode-hook 'turn-on-outline-minor-mode)
(setq outline-minor-mode-prefix "\C-c\C-w")

(provide 'latex-conf)
