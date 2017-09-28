;; http://ergoemacs.org/emacs/emacs_buffer_switching.html
(ido-mode t)
(ido-everywhere 1)
(setq ido-enable-flex-matching t)

(use-package ido-completing-read+
  :config
  (ido-ubiquitous-mode 1))

(use-package smex
  :config
  (smex-initialize)
  :bind (("M-x" . smex)
         ("M-X" . smex-major-mode-commands)
         ;; This is the old M-x.
         ("C-c C-c M-x" . execute-extended-command)))
