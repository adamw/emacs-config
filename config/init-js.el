(use-package js2-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode)) ; http://elpa.gnu.org/packages/js2-mode.html
  (setq-default js2-basic-offset 2)
  (setq-default js-indent-level 2))

(use-package json-mode
  :config
  (setq json-reformat:indent-width 2)

  ;; http://stackoverflow.com/questions/5500035/set-custom-keybinding-for-specific-emacs-mode
  (eval-after-load 'json 
    '(define-key json-mode-map [(tab)] 'json-reformat-region)))

(use-package web-mode
  :config
  (setq-default web-mode-markup-indent-offset 2
                web-mode-css-indent-offset 2
                web-mode-code-indent-offset 2
                web-mode-style-padding 2
                web-mode-script-padding 2))

(use-package tide
  :config
  (tide-setup)
  (tide-hl-identifier-mode +1)
  (add-hook 'before-save-hook 'tide-format-before-save)
  (add-hook 'typescript-mode-hook #'setup-tide-mode))
