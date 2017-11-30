(use-package purescript-mode
  :mode "\\.purs$")
  
(use-package psc-ide
  :config
  (add-hook 'purescript-mode-hook (lambda ()
    (psc-ide-mode)
    (company-mode)
    (flycheck-mode)
    (turn-on-purescript-indentation)))
  (defun psc-ide-ensure ()
    (interactive)
    (let ((prj (projectile-project-root)))
      (progn
        (setq psc-ide-current prj)
        (psc-ide-server-start-impl (expand-file-name prj))
        (sit-for 3) ;; waiting for the server to start to send it commands
        (psc-ide-load-all)
        (message (format "psc-ide started for %s" (projectile-project-name))))))
  
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
  (define-key psc-ide-mode-map (kbd "C-c M-s") nil) ;; remove mapping
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

  ;; https://github.com/epost/psc-ide-emacs/issues/130
  ;; fix goto definition in edited files
  (setq psc-ide-editor-mode t) 
  
  (setq psc-ide-flycheck-ignored-error-codes
        '("ImplicitImport")))
