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
