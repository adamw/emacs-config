;; http://www.rabbitonweb.com/2016/01/31/my-emacs-for-scala-development-part-1/ & https://github.com/bodil/ohai-emacs/
(require 'package)
(setq
 package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                    ("org" . "http://orgmode.org/elpa/")
                    ("melpa" . "http://melpa.org/packages/")
                    ("melpa-stable" . "http://stable.melpa.org/packages/"))
 package-archive-priorities '(("melpa-stable" . 1)))

(when (not package-archive-contents)
  (package-refresh-cpontents))

(when (not (package-installed-p 'use-package))
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package auto-package-update
  :init
  (auto-package-update-maybe))
