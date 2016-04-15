(global-linum-mode t) ; http://superuser.com/questions/212193/how-do-i-display-line-numbers-in-emacs-not-in-the-mode-line

(packages-conditional-install '(linum-off))
(require 'linum-off)

(add-to-list 'linum-disabled-modes-list 'ansi-term)

(show-paren-mode 1)

;; buffer local variables
(setq-default
 indent-tabs-mode nil
 tab-width 2
 c-basic-offset 4)

;; fn+arrows jump to start/end of line, not start/end of buffer
(define-key global-map [home] 'beginning-of-line)
(define-key global-map [end] 'end-of-line)

(packages-conditional-install '(expand-region))
(require 'expand-region)
(global-set-key [(meta up)] 'er/expand-region)

;; modify C-k to kill whole line
(setq kill-whole-line t)
(global-set-key [(control k)] 'kill-whole-line)

;; duplicate line: http://stackoverflow.com/questions/88399/how-do-i-duplicate-a-whole-line-in-emacs
(global-set-key "\C-c\C-d" "\C-a\C- \C-n\M-w\C-y\C-p")

;; overwrite when region selected: https://www.gnu.org/software/emacs/manual/html_node/efaq/Replacing-highlighted-text.html
(delete-selection-mode 1)

;; https://github.com/victorhge/iedit
(packages-conditional-install '(iedit))
(require 'iedit)
