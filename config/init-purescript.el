(use-package purescript-mode
  :config
  (add-to-list 'auto-mode-alist (cons "\\.purs\\'" 'purescript-mode))
  (add-hook 'purescript-mode-hook 'turn-on-purescript-indentation))
