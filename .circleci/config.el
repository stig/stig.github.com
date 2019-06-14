;; Don't make backup copies in ~/public_html
(setq backup-inhibited t)

;; Don't use inline CSS for source code
(setq org-html-htmlize-output-type "css")

(setq org-html-footnotes-section
      "<div id=\"footnotes\"><!--%s-->%s</div>")

(setq org-html-postamble
      "<p>Copyright &copy; Stig Brautaset. <a accesskey=\"l\" href=\"https://creativecommons.org/licenses/by-sa/4.0/\">Licence</a></p>
")

(defun sb/org-html-format-drawer (name content)
  (concat "<div class=\"drawer " (downcase name) "\">\n"
	  "<h6>" (capitalize name) "</h6>\n"
	  content
	  "\n</div>"))

(defun sb/html-head (prefix)
  (format "
       <link rel=\"stylesheet\" type=\"text/css\" href=\"%setc/main.css\" />
       <link rel=\"icon\" type=\"image/png\" href=\"%setc/icon.png\" />
       <link rel=\"alternative\" type=\"application/rss+xml\"
	     href=\"https://www.brautaset.org/index.xml\"
	     title=\"Stig's Soapbox RSS Feed\" />
       <meta name=\"referrer\" content=\"same-origin\">
" prefix prefix))


;; Set to a non-empty string, otherwise our html-home/up-format
;; snippet will not be used.
(setq org-html-link-up "t")

(defun sb/html-home/up-format (prefix)
  (format "
       <div id=\"org-div-home-and-up\">
	 <nav>
	   <ul>
	     <li><a accesskey=\"H\" href=\"%sindex.html\"> Home </a></li>
	     <li><a accesskey=\"p\" href=\"%spublications.html\"> Publications </a></li>
	     <li><a accesskey=\"A\" href=\"%sabout.html\"> About </a></li>
	   </ul>
	 </nav>
       </div>" prefix prefix prefix))

(setq org-publish-project-alist
      `(("www"
	 :components ("www-pages" "www-articles" "www-static" "www-rss"))

	("www-static"
	 :base-directory "~/blog"
	 :publishing-directory "~/public_html"
	 :base-extension "css\\|jpg\\|png\\|pdf\\|html"
	 :recursive t
	 :publishing-function org-publish-attachment)

	("www-pages"
	 :exclude ",.*"
	 :base-directory "~/blog"
	 :publishing-directory "~/public_html"
	 :publishing-function org-html-publish-to-html
	 :section-numbers nil
	 :time-stamp-file nil
	 :with-toc nil
	 :with-drawers t
	 :html-format-drawer-function sb/org-html-format-drawer

	 :html-html5-fancy t
	 :html-doctype "html5"
	 :html-home/up-format ,(sb/html-home/up-format "")
	 :html-head ,(sb/html-head "")

	 :html-head-include-default-style nil
	 :html-head-include-scripts nil

	 :html-metadata-timestamp-format "%e %B %Y")

	("www-articles"
	 :exclude ",.*"
	 :base-directory "~/blog/articles"
	 :publishing-directory "~/public_html/articles"
	 :publishing-function org-html-publish-to-html
	 :recursive t
	 :section-numbers nil
	 :time-stamp-file nil
	 :with-toc nil
	 :with-drawers t
	 :html-format-drawer-function sb/org-html-format-drawer

	 :html-html5-fancy t
	 :html-doctype "html5"
	 :html-home/up-format ,(sb/html-home/up-format "../../")
	 :html-head ,(sb/html-head "../../")

	 :html-head-include-default-style nil
	 :html-head-include-scripts nil

	 :html-metadata-timestamp-format "%e %B %Y")

	("www-rss"
	 :base-directory "~/blog"
	 :base-extension "org"
	 :html-link-home "https://www.brautaset.org"
	 :html-link-use-abs-url t
	 :rss-extension "xml"
	 :publishing-directory "~/public_html"
	 :publishing-function (org-rss-publish-to-rss)
	 :section-numbers nil
	 :exclude ".*"              ;; To exclude all files...
	 :include ("index.org")     ;; ... except index.org.
	 :table-of-contents nil)))

(package-initialize)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/"))
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
