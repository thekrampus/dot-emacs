;;; ESS mode (R & others) configuration
;;; Code:

(if (file-exists-p "/usr/share/emacs/site-lisp/ess")
    ((add-to-list 'load-path "/usr/share/emacs/site-lisp/ess")
     (require 'ess-site)))

(provide 'ess-conf)
