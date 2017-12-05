;; http://www.rabbitonweb.com/2016/01/31/my-emacs-for-scala-development-part-1/ & https://github.com/bodil/ohai-emacs/
(require 'package)
(setq
 package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                    ("org" . "http://orgmode.org/elpa/")
                    ("melpa" . "http://melpa.org/packages/")
                    ("melpa-stable" . "http://stable.melpa.org/packages/")))

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(when (not (package-installed-p 'paradox))
  (package-install 'paradox))

(paradox-require 'use-package)
(require 'use-package)

(setq use-package-always-ensure t)

(use-package auto-package-update
  :config
  (auto-package-update-maybe))
