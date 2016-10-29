;;; sudo-find-file.el --- Use TRAMP to open a file as root
;;; Commentary:
;;; see https://www.emacswiki.org/emacs/TrampMode#toc16

;;; Code:
(defvar sudo-find-file-prefix (if (featurep 'xemacs) "/[sudo/root@localhost]" "/sudo:root@localhost:" )
  "*The filename prefix used to open a file with `sudo-find-file'.")

(defvar sudo-find-file-history nil
  "History list for files found using `sudo-find-file'.")

(defvar sudo-find-file-hook nil
  "Normal hook for functions to run after finding a \"root\" file.")

(defun sudo-find-file ()
  "*Open a file as the root user.
   Prepends `sudo-find-file-prefix' to the selected file name so that it
   maybe accessed via the corresponding tramp method."

  (interactive)
  (require 'tramp)
  (let* ( ;; We bind the variable `file-name-history' locally so we can
         ;; use a separate history list for "root" files.
         (file-name-history sudo-find-file-history)
         (name (or buffer-file-name default-directory))
         (tramp (and (tramp-tramp-file-p name)
                     (tramp-dissect-file-name name)))
         path dir file)

    ;; If called from a "root" file, we need to fix up the path.
    (when tramp
      (setq path (tramp-file-name-localname tramp)
            dir (file-name-directory path)))

    (when (setq file (read-file-name "Find file (UID = 0): " dir path))
      (find-file (concat sudo-find-file-prefix file))
      ;; If this all succeeded save our new history list.
      (setq sudo-find-file-history file-name-history)
      ;; allow some user customization
      (run-hooks 'sudo-find-file-hook))))

(provide 'sudo-find-file)
;;; sudo-find-file ends here
