(global-linum-mode t) ; http://superuser.com/questions/212193/how-do-i-display-line-numbers-in-emacs-not-in-the-mode-line

;; Highlight the line number of the current line.
(use-package hlinum
  :config
  (hlinum-activate))

; turn linum off in some buffers, e.g. term
(use-package linum-off)

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

(use-package expand-region
  :bind ("M-<up>" . er/expand-region))
  
;; modify C-k to kill whole line
(setq kill-whole-line t)
(global-set-key [(control k)] 'kill-whole-line)

;; duplicate line: http://stackoverflow.com/questions/88399/how-do-i-duplicate-a-whole-line-in-emacs
(global-set-key "\C-c\C-d" "\C-a\C- \C-n\M-w\C-y\C-p")

;; overwrite when region selected: https://www.gnu.org/software/emacs/manual/html_node/efaq/Replacing-highlighted-text.html
(delete-selection-mode 1)

;; https://github.com/victorhge/iedit - simultaneously edit same word occurences
(use-package iedit)

;; half-scroll https://www.emacswiki.org/emacs/HalfScrolling
(defun window-half-height ()
  (max 1 (/ (1- (window-height (selected-window))) 2)))

(defun scroll-up-half ()
  (interactive)
  (scroll-up (window-half-height)))

(defun scroll-down-half ()         
  (interactive)                    
  (scroll-down (window-half-height)))

(global-set-key [next] 'scroll-up-half)
(global-set-key [prior] 'scroll-down-half)

;; Always indent after a newline.
(define-key global-map (kbd "RET") 'newline-and-indent)

;; Automatically insert matching braces and do other clever
;; things pertaining to braces and such.
(electric-pair-mode 1)

(when (eq system-type 'darwin)
  (setq mac-right-option-modifier 'none))

;; comment/uncomment line/region
;; from http://stackoverflow.com/questions/9688748/emacs-comment-uncomment-current-line
(defun comment-or-uncomment-region-or-line ()
  "Comments or uncomments the region or the current line if there's no active region."
  (interactive)
  (let (beg end)
    (if (region-active-p)
        (setq beg (region-beginning) end (region-end))
      (setq beg (line-beginning-position) end (line-end-position)))
    (comment-or-uncomment-region beg end)))

(global-set-key "\M-;" 'comment-or-uncomment-region-or-line)

(use-package avy
  :bind
  (("C-'" . avy-goto-char-2)))
