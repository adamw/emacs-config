;; http://www.rabbitonweb.com/2016/01/31/my-emacs-for-scala-development-part-1/
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade.ferrier.me.uk/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defun package-conditional-install (package-name)
  "Install a package if it is not present"
  (unless (package-installed-p package-name)
    (package-refresh-contents) (package-install package-name)))

(defun packages-conditional-install (packages)
  "Install list of packages if not present"
  (when packages
    (package-conditional-install (car packages))
    (packages-conditional-install (cdr packages))))

(package-conditional-install 'auto-package-update)

(auto-package-update-maybe)
