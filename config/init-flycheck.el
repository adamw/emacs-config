(use-package flycheck
  :config
  (global-flycheck-mode t)
  (setq-default flycheck-disabled-checkers
                (append flycheck-disabled-checkers '(javascript-eslint)))
  (setq flycheck-jshintrc "~/.emacs.d/.jshintrc"))
