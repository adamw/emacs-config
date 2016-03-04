;; https://github.com/syohex/emacs-git-gutter
(require 'git-gutter)

(global-git-gutter-mode t)

(git-gutter:linum-setup)

(custom-set-variables
 '(git-gutter:added-sign "+ ")
 '(git-gutter:modified-sign "~ ") 
 '(git-gutter:deleted-sign "- ")
 '(git-gutter:lighter " GG")
 '(git-gutter:update-interval 2))

(set-face-foreground 'git-gutter:added "green")
(set-face-background 'git-gutter:added nil)

(set-face-foreground 'git-gutter:modified "purple")
(set-face-background 'git-gutter:modified nil)

(set-face-foreground 'git-gutter:deleted "red")
(set-face-background 'git-gutter:deleted nil)
