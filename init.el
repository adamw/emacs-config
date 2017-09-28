
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;(package-initialize)

(setq max-lisp-eval-depth 1500
      max-specpdl-size    3000)

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

