(packages-conditional-install '(projectile neotree))

(require 'projectile)

(projectile-global-mode)

(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

(setq neo-smart-open t)
;;(setq projectile-switch-project-action 'neotree-projectile-action)

(setq neo-theme 'arrow)

;; https://github.com/jaypei/emacs-neotree/issues/77
(add-hook 'neo-enter-hook (lambda (type x y)
                            (if (equal type 'file) (neotree-hide))))
