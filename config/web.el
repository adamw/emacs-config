(use-package js2-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode)) ; http://elpa.gnu.org/packages/js2-mode.html
  (setq-default js2-basic-offset 2))

(use-package json-mode
  :config
  (setq json-reformat:indent-width 2)

  ;; http://stackoverflow.com/questions/5500035/set-custom-keybinding-for-specific-emacs-mode
  (eval-after-load 'json 
    '(define-key json-mode-map [(tab)] 'json-reformat-region)))

(use-package web-mode)

(use-package markdown-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
  (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode)))

(use-package purescript-mode
  :config
  (add-to-list 'auto-mode-alist (cons "\\.purs\\'" 'purescript-mode))
  (add-hook 'purescript-mode-hook 'turn-on-purescript-indentation))
