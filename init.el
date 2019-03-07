;;;; .emacs --- Configuration for Emacs
;;;; by Rob Kelly <tetramor.ph>
;;; Commentary:
;; (This is git-controlled in the .emacs.d directory.)
;; (Don't forget to `ln -s ~/.emacs.d/dot-emacs ~/.emacs`)

;;; Code:

;;;; Package management configuration:
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

;;;; Load and configure packages (non-managed):
;; {{{

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
;; }}}

;;;; Major mode hooks & configuration:
;; {{{

;;; Emacs Help mode
(add-hook 'help-mode-hook 'form-feed-mode)

;;; Flycheck mode
(defun flycheck-mode-hook-definition ()
  (define-key flycheck-mode-map flycheck-keymap-prefix nil)
  (setq flycheck-keymap-prefix (kbd "M-f"))
  (define-key flycheck-mode-map flycheck-keymap-prefix flycheck-command-map))
(add-hook 'flycheck-mode-hook 'flycheck-mode-hook-definition)
(add-hook 'after-init-hook 'global-flycheck-mode)

;;; Org mode
(defun org-mode-hook-definition ()
  (autopair-mode -1)
  (fci-mode)
  (defun make-page-number (string)
    (if (= (length string) 0)
        ""
      (concat "::" string))))
(add-hook 'org-mode-hook 'org-mode-hook-definition)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-agenda-files (list "~/org/mroi.org"
                             "~/org/mroi.software.org"
                             "~/org/home.org"))
(setq org-file-apps
      '((auto-mode . emacs)
        ("\\.x?html?\\'" . "chromium %s")
        ("\\.pptx?\\'" . "libreoffice %s")
        ("\\.docx?\\'" . "libreoffice %s")
        ("\\.pdf\\'" . "evince \"%s\"")
        ("\\.pdf::\\([0-9]+\\)\\'" . "evince \"%s\" -p %1")))
(setq org-hide-emphasis-markers t)
(setq org-log-done t)

;;; Processing mode
(add-to-list 'load-path "~/.emacs.d/processing-emacs/")
(autoload 'processing-mode "processing-mode" "Processing mode" t)
(add-to-list 'auto-mode-alist '("\\.pde$" . processing-mode))
(setq processing-location "/usr/bin/processing-java")

;;; ASM mode
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

;;; AUCTeX mode
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

;;; ARFF mode
(require 'arff)

;;; C mode
(add-hook 'c-mode-common-hook '(lambda () (c-set-offset 'case-label '+)))
(add-hook 'c-mode-common-hook '(lambda () (column-enforce-mode 1)))
;; Load CC (C & C++) mode
(require 'cc-mode)
(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)

;;; SQL mode
(eval-after-load "sql"
    (load-library "sql-indent"))
;; (require 'sql-indent)
(add-hook 'sql-mode-hook '(lambda () (column-enforce-mode 1)))

;;; Python mode
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

;;; ESS mode (R & others)
;; (setq load-path (cons "/usr/share/emacs/site-lisp/ess" load-path))
;; (require 'ess-site)

;;; Go language mode
(defun go-mode-hook-definition ()
  (column-enforce-mode 1)
  (auto-complete-mode 1)
  (add-hook 'before-save-hook 'gofmt-before-save)
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go build -v; and go test -v; and go vet"))
  (local-set-key (kbd "M-.") 'godef-jump)
  (local-set-key (kbd "C-c C-c") 'compile)
  (local-set-key (kbd "M-RET") 'go-run))
(add-hook 'go-mode-hook 'go-mode-hook-definition)
(with-eval-after-load 'go-mode
  (require 'go-autocomplete)
  (require 'go-guru))

;;; Rust mode
(defun rust-run-buffer ()
  (interactive)
  (compile "cargo run -v" t))
(defun rust-mode-hook-definition ()
  (column-enforce-mode 1)
  (setq column-enforce-column 100)
  ;; (auto-complete-mode 1)
  (rust-enable-format-on-save)
  (racer-mode)
  ;; (company-mode)
  (if (not (string-match "cargo" compile-command))
      (set (make-local-variable 'compile-command)
           "cargo build -v"))
  (local-set-key (kbd "C-c C-c") 'compile)
  (local-set-key (kbd "M-RET") 'rust-run-buffer))
(defun racer-mode-hook-definition()
  (setq racer-rust-src-path (getenv "RUST_SRC_PATH"))
  (eldoc-mode)
  (company-mode)
  (setq company-tooltip-align-annotations t)
  (local-set-key (kbd "TAB") #'company-indent-or-complete-common))
(add-hook 'rust-mode-hook 'rust-mode-hook-definition)
(add-hook 'flycheck-mode-hook 'flycheck-rust-setup)
(add-hook 'racer-mode-hook 'racer-mode-hook-definition)
(require 'company-racer)
  (with-eval-after-load 'company
    (add-to-list 'company-backends 'company-racer))

;;; nXML mode
(defun nxml-mode-hook-definition ()
  (auto-complete-mode 1)
  (local-set-key (kbd "M-{") 'nxml-backward-element)
  (local-set-key (kbd "M-}") 'nxml-forward-element)
  (local-set-key (kbd "M-_") 'nxml-backward-up-element)
  (local-set-key (kbd "M-+") 'nxml-down-element))
(add-hook 'nxml-mode-hook 'nxml-mode-hook-definition)
;; }}}

;;;; Miscellaneous configuration:
;; {{{

;; Global keybindings
(global-set-key (kbd "C-g") 'goto-line)
(global-set-key (kbd "C-f") 'dabbrev-expand)
(global-set-key (kbd "M-/") 'comment-or-uncomment-region)
(global-set-key (kbd "C-x <C-left>") 'previous-multiframe-window)
(global-set-key (kbd "C-x <C-right>") 'next-multiframe-window)

;; Just emacs things (dot tumblr dot com)
(setq-default column-number-mode t)
(set-variable 'frame-background-mode 'dark)
(setq default-fill-column 80)

;; four-space tabs four-life, fam.
(setq-default c-default-style "linux"
			  c-basic-offset 4
			  tab-width 4
			  indent-tabs-mode nil)

;; startup behavior -- launch to scratch buffer w/ logo
(setq inhibit-startup-screen t)
(setq initial-scratch-message
      (with-temp-buffer
        (insert-file-contents "~/.emacs.d/logos/default")
        (buffer-string)))

;; Should use chromium as default browser
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "chromium")

;; }}}

;;;; "Custom" settings -- autogenerated, avoid editing where possible...
;; {{{
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-item-indent 0)
    '(TeX-command-list
         (quote
             (("TeX" "%(PDF)%(tex) %(extraopts) %`%S%(PDFout)%(mode)%' %t" TeX-run-TeX nil
                  (plain-tex-mode texinfo-mode ams-tex-mode)
                  :help "Run plain TeX")
                 ("LaTeX" "%`%l%(mode) -shell-escape%' %t" TeX-run-TeX nil
                     (latex-mode doctex-mode)
                     :help "Run LaTeX")
                 ("Makeinfo" "makeinfo %(extraopts) %t" TeX-run-compile nil
                     (texinfo-mode)
                     :help "Run Makeinfo with Info output")
                 ("Makeinfo HTML" "makeinfo %(extraopts) --html %t" TeX-run-compile nil
                     (texinfo-mode)
                     :help "Run Makeinfo with HTML output")
                 ("AmSTeX" "%(PDF)amstex %(extraopts) %`%S%(PDFout)%(mode)%' %t" TeX-run-TeX nil
                     (ams-tex-mode)
                     :help "Run AMSTeX")
                 ("ConTeXt" "texexec --once --texutil %(extraopts) %(execopts)%t" TeX-run-TeX nil
                     (context-mode)
                     :help "Run ConTeXt once")
                 ("ConTeXt Full" "texexec %(extraopts) %(execopts)%t" TeX-run-TeX nil
                     (context-mode)
                     :help "Run ConTeXt until completion")
                 ("BibTeX" "bibtex %s" TeX-run-BibTeX nil t :help "Run BibTeX")
                 ("Biber" "biber %s" TeX-run-Biber nil t :help "Run Biber")
                 ("View" "bash -c \"if pgrep -f '^xpdf.*%s'; then xpdf -remote %s -reload; else xpdf -cont -remote %s %s.pdf; fi\"" TeX-run-discard-or-function t t :help "Run Viewer")
                 ("Print" "%p" TeX-run-command t t :help "Print the file")
                 ("Queue" "%q" TeX-run-background nil t :help "View the printer queue" :visible TeX-queue-command)
                 ("File" "%(o?)dvips %d -o %f " TeX-run-command t t :help "Generate PostScript file")
                 ("Index" "makeindex %s" TeX-run-command nil t :help "Create index file")
                 ("Xindy" "texindy %s" TeX-run-command nil t :help "Run xindy to create index file")
                 ("Check" "lacheck %s" TeX-run-compile nil
                     (latex-mode)
                     :help "Check LaTeX file for correctness")
                 ("ChkTeX" "chktex -v6 %s" TeX-run-compile nil
                     (latex-mode)
                     :help "Check LaTeX file for common mistakes")
                 ("Spell" "(TeX-ispell-document \"\")" TeX-run-function nil t :help "Spell-check the document")
                 ("Clean" "TeX-clean" TeX-run-function nil t :help "Delete generated intermediate files")
                 ("Clean All" "(TeX-clean t)" TeX-run-function nil t :help "Delete generated intermediate and output files")
                 ("Other" "" TeX-run-command t t :help "Run an arbitrary command"))))
 '(gud-gdb-command-name "gdb --annotate=1")
 '(haskell-mode-hook (quote (turn-on-haskell-indentation)))
 '(large-file-warning-threshold nil)
 '(nxml-slash-auto-complete-flag t)
    '(org-agenda-files
         (quote
             ("~/org/mroi.software.org" "~/org/mroi.org" "~/org/home.org")) t)
    '(package-selected-packages
         (quote
             (auto-virtualenvwrapper virtualenvwrapper editorconfig thrift fill-column-indicator dockerfile-mode racer cargo company company-racer autopair flycheck-rust flymake-rust rust-mode rustfmt go-playground go-guru go-autocomplete go-direx go-mode slime pythonic popup-complete matlab-mode lua-mode jedi haskell-mode form-feed fish-mode eldoc-extension eldoc-eval column-enforce-mode c-eldoc auto-complete-auctex ac-racer ac-octave ac-math ac-c-headers)))
    '(safe-local-variable-values
         (quote
             ((whitespace-style face tabs spaces trailing lines space-before-tab::space newline indentation::space empty space-after-tab::space space-mark tab-mark newline-mark)))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; }}}
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
