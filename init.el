(add-to-list 'load-path "~/.emacs.d/config/")
(add-to-list 'load-path "~/.emacs.d/custom/")

(load "common")

(package-install-all '(js2-mode ensime monokai-theme smex flycheck json-mode web-mode auto-complete git-gutter magit projectile ido-ubiquitous))

(load-theme 'monokai t)

(load "ido-config")
(load "smex-config")
(load "auto-complete-cfg")
(load "comint-config")
(load "js2-config")
(load "flycheck-config")
(load "json-config")
(load "diff-hl-config")
(load "magit-config")
(load "projectile-config")

(load "movelines")
(load "rename-file-buffer")
