;;; etc --- miscellaneous config
;;; Code:

;; Global keybindings
(global-set-key (kbd "C-g") 'goto-line)
(global-set-key (kbd "C-f") 'dabbrev-expand)
(global-set-key (kbd "M-/") 'comment-or-uncomment-region)
(global-set-key (kbd "C-x <C-left>") 'previous-multiframe-window)
(global-set-key (kbd "C-x <C-right>") 'next-multiframe-window)

(provide 'etc-conf)
