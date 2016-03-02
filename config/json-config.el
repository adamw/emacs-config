(require 'json-mode)
(setq json-reformat:indent-width 2)	

(eval-after-load 'json 
  '(define-key json-mode-map [(tab)] 'json-reformat-region))
