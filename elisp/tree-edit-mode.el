;; A mode for drawing trees.
;; Quick-n-dirty because I'm procrastinating from doing something else...

(defvar tree-edit-map
  (let ((map (make-sparse-keymap)))
	(define-key map (kbd "M-RET") 'tree-edit-newline)
	(define-key map (kbd "M-\\") 'tree-edit-indent)
	(define-key map (kbd "M-|") 'tree-edit-unindent)
	map))

(define-minor-mode tree-edit-mode
  "Keybindings for drawing trees"
  :lighter " tree-edit"
  :keymap tree-edit-map)

(defun tree-edit-indent ()
  (interactive)
  (save-excursion
	(beginning-of-line)
	(insert "│   ")))

(defun tree-edit-unindent ()
  (interactive)
  (save-excursion
	(let ((beg (beginning-of-line))
		  (end (end-of-line)))
	  (beginning-of-line)
	  (re-search-forward "^│   " end nil 1)
	  (replace-match ""))))

(defun tree-edit-newline ()
  (interactive)
  (let* ((beg (line-beginning-position))
		 (end (line-end-position)))
	(beginning-of-line)
	(search-forward "──" end nil 1)
	(backward-char 2)
	(kill-ring-save beg (point))
	(delete-backward-char 1)
	(insert "├")
	(end-of-line)
	(newline)
	(yank)
	(insert "── ")))

(provide 'tree-edit-mode)
