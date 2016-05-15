(use-package purescript-mode
  :commands purescript-mode
  :mode (("\\.purs$" . purescript-mode))
  :config
  (add-hook 'purescript-mode-hook 'turn-on-purescript-indentation))

(use-package psc-ide
  :init
  (setq psc-ide-client-executable "psc-ide-client")
  (setq psc-ide-server-executable "psc-ide-server")
  :config
  (defvar psc-ide-current nil)

  (defun psc-ide-ensure ()
    (interactive)
    (let ((prj (projectile-project-root)))
      (if (or (eq prj nil) (eq prj psc-ide-current))
          (message "No project or already running for current project")
        (progn
          (setq psc-ide-current prj)
          (psc-ide-server-quit)
          (psc-ide-server-start-impl (expand-file-name prj))
          (sit-for 1) ;; waiting for the server to start to send it commands
          (psc-ide-load-all)
          (message (format "psc-ide started for %s" (projectile-project-name)))))))
  
  ;; remove original mappings
  (define-key psc-ide-mode-map (kbd "C-c C-s") nil) ;; remove mapping
  (define-key psc-ide-mode-map (kbd "C-c C-q") nil) ;; remove mapping
  (define-key psc-ide-mode-map (kbd "C-c C-l") nil) ;; remove mapping
  (define-key psc-ide-mode-map (kbd "C-c C-S-l") nil) ;; remove mapping
  (define-key psc-ide-mode-map (kbd "C-c C-a") nil) ;; remove mapping
  (define-key psc-ide-mode-map (kbd "C-c C-c") nil) ;; remove mapping
  (define-key psc-ide-mode-map (kbd "C-c C-i") nil) ;; remove mapping
  (define-key psc-ide-mode-map (kbd "C-c C-t") nil) ;; remove mapping
  ;; bind to a new keymap
  (define-prefix-command 'psc-ide-extra-map)
  (define-key psc-ide-mode-map (kbd "C-c i") 'psc-ide-extra-map)
  (define-key psc-ide-extra-map (kbd "e") 'psc-ide-ensure)
  (define-key psc-ide-extra-map (kbd "s") 'psc-ide-server-start)
  (define-key psc-ide-extra-map (kbd "q") 'psc-ide-server-quit)
  (define-key psc-ide-extra-map (kbd "l") 'psc-ide-load-all)
  (define-key psc-ide-extra-map (kbd "L") 'psc-ide-load-module)
  (define-key psc-ide-extra-map (kbd "a") 'psc-ide-add-clause)
  (define-key psc-ide-extra-map (kbd "c") 'psc-ide-case-split)
  (define-key psc-ide-extra-map (kbd "i") 'psc-ide-add-import)
  (define-key psc-ide-extra-map (kbd "t") 'psc-ide-show-type)
  (define-key psc-ide-extra-map (kbd "b") 'psc-ide-rebuild)
  (add-hook 'purescript-mode-hook 'psc-ide-mode))

;; Copied from https://github.com/bodil/ohai-emacs
;; Extend Flycheck with psc-ide capabilities.
(with-eval-after-load "flycheck"
  (flycheck-def-option-var flycheck-psc-ide-ignore-error-codes nil psc
    "List of psc error codes to ignore.

The value of this variable is a list of strings, where each
string is a name of an error code to ignore (e.g. \"MissingTypeDeclaration\")."
    :type '(repeat :tag "Extensions" (string :tag "Extension"))
    :safe #'flycheck-string-list-p)

  (setq flycheck-psc-ide-ignore-error-codes '("ImplicitImport" "MissingTypeDeclaration"))
  
  (flycheck-define-generic-checker 'flycheck-psc-ide
   "Check buffer using psc-ide rebuild."
   :start (lambda (checker done)
            (funcall done 'finished (ohai-purescript/rebuild-to-flycheck)))
   :modes 'purescript-mode)
  (add-to-list 'flycheck-checkers 'flycheck-psc-ide)
  
  (defun ohai-purescript/rebuild-to-flycheck ()
    "Rebuild the current module."
    (let* ((res (json-read-from-string
                 (psc-ide-send (psc-ide-command-rebuild))))
           (is-success (string= "success" (cdr (assoc 'resultType res))))
           (result (cdr (assoc 'result res))))
      (ohai-purescript/save-suggestions (append result nil))
      (-filter (lambda (i) (not (eq i nil)))
               (if (not is-success)
                   (-map (lambda (err)
                           (ohai-purescript/error 'error err))
                         result)
                 (if (> (length result) 0)
                     (-map (lambda (err)
                             (ohai-purescript/error 'warning err))
                           result)
                   nil)))))

  (defun ohai-purescript/save-suggestions (errs)
    (setq-local
     ohai-purescript/suggestions
     (-map
      (lambda (err)
        (let* ((err-filename (cdr (assoc 'filename err)))
               (err-position (cdr (assoc 'position err)))
               (err-line (cdr (assoc 'startLine err-position)))
               (err-column (cdr (assoc 'startColumn err-position)))
               (err-id (concat err-filename ":" (number-to-string err-line)
                               ":" (number-to-string err-column))))
          (cons err-id err)))
      (-filter (lambda (i) (and (cdr (assoc 'position i))
                                (cdr (assoc 'suggestion i))))
               errs))))

  (defun ohai-purescript/error (severity err)
    (let* ((err-message (cdr (assoc 'message err)))
           (err-filename (cdr (assoc 'filename err)))
           (err-position (cdr (assoc 'position err)))
           (err-code (cdr (assoc 'errorCode err)))
           (err-line (cdr (assoc 'startLine err-position)))
           (err-column (cdr (assoc 'startColumn err-position))))
      (when (and err-position (not (member err-code flycheck-psc-ide-ignore-error-codes)))
        (flycheck-error-new-at
         err-line
         err-column
         severity
         (concat err-code ":" err-message)
         :id (concat err-filename ":" (number-to-string err-line)
                     ":" (number-to-string err-column))))))

  (defun ohai-purescript/insert-suggestion ()
    (interactive)
    (let* ((id (flycheck-error-id (car (flycheck-overlay-errors-at (point)))))
           (err (cdr (assoc id ohai-purescript/suggestions)))
           (pos (cdr (assoc 'position err)))
           (sugg (cdr (assoc 'suggestion err))))
      (if (and pos sugg)
          (let* ((start (save-excursion
                          (goto-char (point-min))
                          (forward-line (- (cdr (assoc 'startLine pos)) 1))
                          (move-to-column (- (cdr (assoc 'startColumn pos)) 1))
                          (point)))
                 (end (save-excursion
                        (goto-char (point-min))
                        (forward-line (- (cdr (assoc 'endLine pos)) 1))
                        (move-to-column (- (cdr (assoc 'endColumn pos)) 1))
                        (point))))
            (progn
              (kill-region start end)
              (goto-char start)
              (let ((new-end
                     (save-excursion
                       (insert (cdr (assoc 'replacement sugg)))
                       (point))))
                (set-mark start)
                (goto-char new-end)
                (setq deactivate-mark nil))))
        (message "No suggestion available!"))))

  (define-key purescript-mode-map (kbd "C-c M-s")
    'ohai-purescript/insert-suggestion))

