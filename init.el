(setq max-lisp-eval-depth 1500
      max-specpdl-size    3000)

;(package-initialize)

(add-to-list 'load-path "~/.emacs.d/config/")
(add-to-list 'load-path "~/.emacs.d/custom/")

(load "init-packages")
(load "init-ui")
(load "init-varia")
(load "init-editor")
(load "init-ido")
(load "init-company")
(load "init-flycheck")
(load "init-git")
(load "init-js")
(load "init-purescript")
(load "init-md")
(load "init-projectile")
(load "init-neotree")
(load "init-modeline")
(load "init-persistent-scratch")
(load "init-ag")
(load "init-helm")
(load "init-web")
(load "init-scala")

(load "movelines")
(load "rename-file-buffer")
(load "autosave")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (ensime yaml-mode pug-mode yasnippet whole-line-or-region which-key web-mode use-package smex smartparens smart-mode-line scala-mode2 sbt-mode purescript-mode psc-ide projectile persistent-scratch neotree monokai-theme markdown-mode magit linum-off json-mode js2-mode iedit ido-ubiquitous hlinum helm-ag git-gutter flycheck-purescript flycheck-color-mode-line expand-region exec-path-from-shell diff-hl company-try-hard company-quickhelp avy auto-package-update auto-complete ag))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
