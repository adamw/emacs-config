;; http://ergoemacs.org/emacs/emacs_buffer_switching.html
(ido-mode t)
(setq ido-everywhere 1)
(setq ido-enable-flex-matching t)

(use-package ido-ubiquitous
  :config
  (ido-ubiquitous-mode 1))

(use-package smex
  :config
  (smex-initialize)
  :bind (("M-x" . smex)
         ("M-X" . smex-major-mode-commands)
         ;; This is the old M-x.
         ("C-c C-c M-x" . execute-extended-command)))

(use-package auto-complete
  :config
  (use-package auto-complete-config)
  (ac-config-default)
  (global-auto-complete-mode t)
  ;; http://stackoverflow.com/questions/11484225/fix-an-auto-complete-mode-and-linum-mode-annoyance
  (ac-linum-workaround)
  ;; link js-mode dictionary to js2-mode so that completion works for js2
  (dolist (el ac-dictionary-directories)
    (if (file-exists-p (concat el "/js-mode"))
        (let ((source (concat el "/js-mode"))
              (target (concat el "/js2-mode")))
          (if (not (file-exists-p target))
              (make-symbolic-link source target))))))
