;;; C & C++ configuration
;;; Code:

(add-hook 'c-mode-common-hook '(lambda () (c-set-offset 'case-label '+)))
(add-hook 'c-mode-common-hook '(lambda () (column-enforce-mode 1)))
;; Load CC (C & C++) mode
(require 'cc-mode)
(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)

(provide 'c-conf)
