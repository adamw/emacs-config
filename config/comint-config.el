;; http://superuser.com/questions/139815/how-do-you-run-the-previous-command-in-emacs-shell
(require 'comint)
(define-key comint-mode-map (kbd "<up>") 'comint-previous-input)
(define-key comint-mode-map (kbd "<down>") 'comint-next-input)
