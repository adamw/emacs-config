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
  
;; C-w and M-w cut/copy the whole line if no region is selected
(use-package whole-line-or-region
  :config
  (whole-line-or-region-mode))

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

(require 'ansi-color)
(defun display-ansi-colors ()
  (interactive)
  (ansi-color-apply-on-region (point-min) (point-max)))

;; enable mouse in terminal (https://www.iterm2.com/faq.html)
(require 'mwheel)
(require 'mouse)
(xterm-mouse-mode t)
(mouse-wheel-mode t)
(global-set-key [mouse-4] 'next-line)
(global-set-key [mouse-5] 'previous-line)

;; macos: fast scrolling http://superuser.com/questions/1133436/way-too-fast-scrolling-in-emacs-on-osx
(setq mouse-wheel-scroll-amount '(3 ((shift) . 1) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)

;; copy-paste in terminal: https://stackoverflow.com/questions/9985316/how-to-paste-to-emacs-from-clipboard-on-osx
(defun copy-from-osx ()
(shell-command-to-string "pbpaste"))

(defun paste-to-osx (text &optional push)
(let ((process-connection-type nil))
(let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
(process-send-string proc text)
(process-send-eof proc))))

(setq interprogram-cut-function 'paste-to-osx)
(setq interprogram-paste-function 'copy-from-osx)
