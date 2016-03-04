(require 'flycheck)

(global-flycheck-mode t)
(setq-default flycheck-disabled-checkers
              (append flycheck-disabled-checkers '(javascript-eslint)))
(setq-default flycheck-idle-change-delay 2.0)
(setq flycheck-jshintrc "~/.emacs.d/.jshintrc")

