(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)

(use-package monokai-theme
  :config
  (load-theme 'monokai t))

(desktop-save-mode 1)

(toggle-frame-maximized)

;; Don't defer screen updates when performing operations.
(setq redisplay-dont-pause t)

;; http://www.lonecpluspluscoder.com/2015/09/14/using-the-hack-2-0-font-in-emacs-on-os-x/
(when (eq system-type 'darwin)
      (set-default-font "-*-Hack-normal-normal-normal-*-12-*-*-*-m-0-iso10646-1"))

(global-set-key (kbd "s-<return>") 'toggle-frame-fullscreen)
