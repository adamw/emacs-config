(use-package flycheck
  :bind (("M-n" . flycheck-next-error)
         ("M-p" . flycheck-previous-error))
  :config
  (global-flycheck-mode t)
  (setq-default flycheck-disabled-checkers
                (append flycheck-disabled-checkers '(javascript-eslint)))
  (setq flycheck-jshintrc "~/.emacs.d/.jshintrc"))

(use-package flycheck-color-mode-line
  :config
  (eval-after-load "flycheck"
    '(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))
  (set-face-foreground 'flycheck-color-mode-line-error-face "#870000")
  (set-face-background 'flycheck-color-mode-line-warning-face "#707070"))
