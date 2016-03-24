(packages-conditional-install '(projectile neotree))

(require 'projectile)

(projectile-global-mode)

(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

(setq neo-smart-open t)
;;(setq projectile-switch-project-action 'neotree-projectile-action)

(setq neo-theme 'arrow)

;; https://github.com/jaypei/emacs-neotree/issues/77 + https://github.com/hemmvm/dotemacs/blob/master/site-lisp/util--neotree.el
(defun custom-neotree-enter-hide ()
  (interactive)
  (neotree-enter)
  (neotree-hide)
  )

(defun custom-neotree-peek ()
  (interactive)
  (let ((neo-window (neo-global--get-window)))
    (neotree-enter)
    (select-window neo-window))
  )

(add-hook
 'neotree-mode-hook
 (lambda ()
   (define-key neotree-mode-map (kbd "RET") 'custom-neotree-enter-hide)))

(add-hook
 'neotree-mode-hook
 (lambda ()
   (define-key neotree-mode-map (kbd "TAB") 'custom-neotree-peek)))
