(package-initialize)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(package-refresh-contents)

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)

(use-package htmlize :ensure t)

(use-package clojure-mode :ensure t)
(use-package clojure-mode-extra-font-locking :ensure t)

(use-package scala-mode :ensure t)

(use-package org
  :ensure org-plus-contrib
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((ditaa . t))))

(message "Installed all packages")
