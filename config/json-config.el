(require 'json-mode)
(setq json-reformat:indent-width 2)	

;; http://stackoverflow.com/questions/5500035/set-custom-keybinding-for-specific-emacs-mode
(eval-after-load 'json 
  '(define-key json-mode-map [(tab)] 'json-reformat-region))
