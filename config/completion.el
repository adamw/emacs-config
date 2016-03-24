(packages-conditional-install '(ido-ubiquitous smex auto-complete))

;; http://ergoemacs.org/emacs/emacs_buffer_switching.html
(ido-mode t)
(setq ido-everywhere 1)
(setq ido-enable-flex-matching t)

(require 'ido-ubiquitous)
(ido-ubiquitous-mode 1)

(require 'smex) 
(smex-initialize)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(require 'auto-complete)
(require 'auto-complete-config)

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
            (make-symbolic-link source target)))))

