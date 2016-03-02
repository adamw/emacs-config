(add-to-list 'load-path "~/.emacs.d/config")
(add-to-list 'load-path "~/.emacs.d/custom")

(load "common.el")

(package-install-all '(js2-mode ensime monokai-theme smex flycheck json-mode web-mode auto-complete))

(load-theme 'monokai t)

(load "smex-config.el")
(load "auto-complete-config.el")
(load "comint-config.el")
(load "js2-config.el")
(load "flycheck-config.el")

(load "movelines.el")
(load "rename-file-buffer.el")
