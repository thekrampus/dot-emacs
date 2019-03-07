;;; Configuration of minor modes and other small things
;;; Code:

;; Remote file editing through scp
(require 'tramp)
(setq tramp-default-method "ssh")
(set-default 'tramp-default-proxies-alist (quote ((".*" "\\ `root\\'" "/ssh:%h"))))

;; Load autopair
(require 'autopair)
(autopair-global-mode)
(eval-after-load "tex-mode"
  '(modify-syntax-entry ?$ "\"" latex-mode-syntax-table))

;; Load whitespace mode and bind
(require 'whitespace)
(global-set-key (kbd "C-x w") 'whitespace-mode)

;; Load linum mode
(require 'linum)
(global-linum-mode)

;; Load IDO (Interactively Do Things)
(require 'ido)
;; (ido-mode t)

;; Load tree edit mode
(require 'tree-edit-mode)

;; Load cloneline.el
(require 'clone-line)
(global-set-key (kbd "M-:") (lambda() (interactive) (clone-line t)))

;; Load sudo-find-file.el
(require 'sudo-find-file)
(global-set-key (kbd "C-x C-r") 'sudo-find-file)

;; auto-complete configuration
;; (ac-config-default)
(setq
 ac-auto-start 2
 ac-override-local-map nil
 ac-use-menu-map t
 ac-candidate-limit 20
 ac-auto-show-menu 0.3
 ac-delay 0.05)

;; editorconfig
(require 'editorconfig)
(editorconfig-mode 1)

;;; Emacs Help mode
(add-hook 'help-mode-hook 'form-feed-mode)

;;; ARFF mode
(require 'arff)

(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

(provide 'minor-conf)
