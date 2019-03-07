;;;; Package management configuration:
;;; Code:
;; {{{
(add-to-list 'load-path "~/.emacs.d/elisp")
(package-initialize)

;; package manager initialization
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")))


(defun install-base-packages ()
  "Install all packages marked selected by Custom. These are updated automatically by Emacs 25"
  (interactive)
  (unless package-archive-contents
    (package-refresh-contents))
  (dolist (package package-selected-packages)
    (unless (package-installed-p package)
      (package-install package))))

;;; Selected packages:
(setq package-selected-packages
      '(racer
        cargo
        company
        company-racer
        autopair
        editorconfig
        fill-column-indicator
        flycheck-rust
        flymake-rust
        rust-mode
        rustfmt
        thrift
        go-playground
        go-guru
        go-autocomplete
        go-direx
        go-mode
        slime
        pythonic
        popup-complete
        matlab-mode
        lua-mode
        jedi
        haskell-mode
        form-feed
        fish-mode
        eldoc-extension
        eldoc-eval
        column-enforce-mode
        c-eldoc
        auto-complete-auctex
        ac-racer
        ac-octave
        ac-math
        ac-c-headers))
;; }}}

(provide 'package-conf)
