;; http://stackoverflow.com/questions/2423834/move-line-region-up-and-down-in-emacs

;; move line up
(defun move-line-up ()
  (interactive)
  (transpose-lines 1)
  (previous-line 2))

(global-set-key [(shift meta up)] 'move-line-up)

;; move line down
(defun move-line-down ()
  (interactive)
  (next-line 1)
  (transpose-lines 1)
  (previous-line 1))

(global-set-key [(shift meta down)] 'move-line-down)
