;;; Python mode configuration
;;; Code:

(require 'jedi)
(require 'auto-virtualenvwrapper)
(defun python-mode-hook-definition ()
    (column-enforce-mode 1)
    (auto-virtualenvwrapper-activate)
    (jedi:setup)
    (jedi-mode)
    )
(setq jedi:complete-on-dot t)
(add-hook 'python-mode-hook 'python-mode-hook-definition)
;; ipython setup
(setq-default python-shell-interpreter "ipython")
(setq-default python-shell-interpreter-args "-i")

(provide 'python-conf)
