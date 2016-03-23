;; http://ergoemacs.org/emacs/emacs_buffer_switching.html
(ido-mode t)
(setq ido-everywhere 1)
(setq ido-enable-flex-matching t)

(require 'ido-ubiquitous)
(ido-ubiquitous-mode 1)

;; http://emacsblog.org/2008/05/19/giving-ido-mode-a-second-chance/
(add-hook 'ido-setup-hook 
          (lambda () 
            (define-key ido-completion-map [tab] 'ido-complete)))
