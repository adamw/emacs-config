(packages-conditional-install '(flycheck flycheck-purescript))

(require 'flycheck)

(global-flycheck-mode t)
(setq-default flycheck-disabled-checkers
              (append flycheck-disabled-checkers '(javascript-eslint)))
(setq-default flycheck-idle-change-delay 2.0)
(setq-default flycheck-check-syntax-automatically '(idle-change))
(setq flycheck-jshintrc "~/.emacs.d/.jshintrc")

(require 'flycheck-purescript)

(eval-after-load 'flycheck '(flycheck-purescript-setup))

(setq flycheck-purescript-ignore-error-codes '("ImplicitImport" "MissingTypeDeclaration"))
