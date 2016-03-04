;; https://github.com/dgutov/diff-hl
(require 'diff-hl)

(add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)

(global-diff-hl-mode t)
(diff-hl-flydiff-mode)

(add-hook 'dired-mode-hook 'diff-hl-dired-mode)
