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
  (define-key psc-ide-mode-map (kbd "C-c C-b") nil) ;; remove mapping
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
  (define-key psc-ide-extra-map (kbd "g") 'psc-ide-flycheck-insert-suggestion)

  (setq psc-ide-flycheck-ignored-error-codes
        '("ImplicitImport" "MissingTypeDeclaration"))
  
  (add-hook 'purescript-mode-hook
    (lambda ()
      (psc-ide-mode)
      (company-mode)))

  ;; as a work-around for https://github.com/epost/psc-ide-emacs/issues/50, saving the file
  ;; always before a check
  (defun save-if-modified ()
    (when (and buffer-file-name
               (buffer-modified-p (current-buffer))
               (file-writable-p buffer-file-name))
      (save-buffer)))
  
  (defun flycheck-purescript-autosave-hook ()
    "Add the current dir to the clang checker include list"
    (if (derived-mode-p 'purescript-mode)
        (save-if-modified)))
  
  (add-hook 'flycheck-before-syntax-check-hook 'flycheck-purescript-autosave-hook))
