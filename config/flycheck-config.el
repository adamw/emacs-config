(require 'flycheck)

(global-flycheck-mode)
(setq-default flycheck-disabled-checkers
              (append flycheck-disabled-checkers '(javascript-eslint)))

