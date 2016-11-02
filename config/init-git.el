(use-package magit
  :bind ("C-x g" . magit-status)
  :config
  (setq magit-completing-read-function 'magit-ido-completing-read))

;; https://github.com/dgutov/diff-hl
(use-package diff-hl
  :bind (("C-c k" . save-and-revert-hunk)
         ("M-]" . diff-hl-next-hunk)
         ("M-[" . diff-hl-previous-hunk))
  :config
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)
  (global-diff-hl-mode t)
  (diff-hl-flydiff-mode)
  (add-hook 'dired-mode-hook 'diff-hl-dired-mode))

(defun save-and-revert-hunk ()
  (interactive)
  (save-buffer)
  (diff-hl-revert-hunk))
