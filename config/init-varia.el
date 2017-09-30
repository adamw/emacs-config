(setq
 inhibit-startup-screen t
 create-lockfiles nil
 make-backup-files nil
 column-number-mode t
 scroll-error-top-bottom t
 show-paren-delay 0
 sentence-end-double-space nil ; above mostly from ensime docs
 ns-pop-up-frames nil ; http://superuser.com/questions/277755/emacs-opens-files-in-a-new-frame-when-opened-with-open-a/431601#431601?newreg=6d0dafa353314a5f88b9a04bb497d088
 )

(fset `yes-or-no-p `y-or-n-p)

;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; from Prelude (https://github.com/bbatsov/prelude)

;; revert buffers automatically when underlying files are changed externally
(global-auto-revert-mode t)

;; smart tab behavior - indent or complete
(setq tab-always-indent 'complete)

;; http://superuser.com/questions/139815/how-do-you-run-the-previous-command-in-emacs-shell
(require 'comint)
(define-key comint-mode-map (kbd "<up>") 'comint-previous-input)
(define-key comint-mode-map (kbd "<down>") 'comint-next-input)

(use-package exec-path-from-shell       
  :config
  (when (memq window-system '(mac ns))
    (exec-path-from-shell-initialize)))

(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; workaround for "ls does not support --dired" http://stackoverflow.com/questions/25125200/emacs-error-ls-does-not-support-dired
(setq dired-use-ls-dired nil)

;; terminal setup: http://jr0cket.co.uk/2012/10/using-emacs-24-server-on-mac-osx-for.html.html
(server-start)


