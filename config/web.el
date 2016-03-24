(packages-conditional-install '(js2-mode web-mode json-mode))

(require 'js2-mode)

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode)) ; http://elpa.gnu.org/packages/js2-mode.html

(setq-default js2-basic-offset 2)

(require 'json-mode)
(setq json-reformat:indent-width 2)	

;; http://stackoverflow.com/questions/5500035/set-custom-keybinding-for-specific-emacs-mode
(eval-after-load 'json 
  '(define-key json-mode-map [(tab)] 'json-reformat-region))

(require 'web-mode)
