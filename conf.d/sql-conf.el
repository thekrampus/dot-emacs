;;; SQL mode configuration
;;; Code:

(eval-after-load "sql"
    (load-library "sql-indent"))
;; (require 'sql-indent)
(add-hook 'sql-mode-hook '(lambda () (column-enforce-mode 1)))

(provide 'sql-conf)
