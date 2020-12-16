(setq org-export-allow-bind-keywords t)

;; Don't use inline CSS for source code
(setq org-html-htmlize-output-type "css")

(setq sb/copyright "<p>Copyright &copy; 2001-2020 Stig Brautaset</p>")

(setq org-html-footnotes-section "<div id=\"footnotes\"><hr/><!--%s-->%s</div>")

(setq org-html-format-drawer-function
      (lambda (name content)
	(format "<div class=\"drawer %s\"><h6>%s</h6>%s</div>"
		(downcase name)
		(capitalize name)
		content)))

(setq org-html-home/up-format "
<div id=\"org-div-home-and-up\">
  <nav>
    <a accesskey=\"h\" href=\"%s\">Home</a> 
    |
    <a accesskey=\"H\" href=\"%s\">About</a>
  </nav>
</div>
")

(setq common-properties
      `(:author "Stig Brautaset"
	:email "stig@brautaset.org"

	:section-numbers nil
	:time-stamp-file nil
	:with-drawers t
	:with-toc nil

	:html-doctype "html5"

	:html-head ,(concat "<style type=\"text/css\">"
			    "/*<![CDATA[*/"
			     (with-temp-buffer
			       (insert-file-contents (expand-file-name "~/blog/style.css"))
			       (buffer-string))
			     "/*]]>*/"
			    "</style>")
        :html-head-include-default-style nil
	:html-head-include-scripts nil
	:html-html5-fancy t
	:html-metadata-timestamp-format "%e %B %Y"))

(setq org-publish-project-alist
      `(("www"
	 :components ("www-pages" "www-articles" "www-rss"))

        ("www-pages"
	 ,@common-properties
	 :base-directory "~/blog"
         :exclude ".*"
	 :html-postamble ,sb/copyright
	 :include ("index.org" "articles.org" "about.org" "style-demo.org")
	 :publishing-directory "~/blog"
	 :publishing-function org-html-publish-to-html)

	("www-articles"
	 ,@common-properties
	 :base-directory "~/blog/articles"
         :html-postamble ,sb/copyright
	 :publishing-directory "~/blog/articles"
	 :publishing-function org-html-publish-to-html
	 :recursive t)

	("www-rss"
	 ,@common-properties
	 :base-directory "~/blog"
	 :exclude ".*"
	 :html-link-home "https://www.brautaset.org"
	 :html-link-use-abs-url t
	 :include ("feed.org")
	 :publishing-directory "~/blog"
	 :publishing-function (org-rss-publish-to-rss)
	 :rss-image-url "https://www.brautaset.org/icon.png"
	 :rss-extension "xml")))

;; Turn off a harmless (but annoying) warning during publication.
;; ("Can't guess python-indent-offset, using defaults 4")
(setq python-indent-guess-indent-offset-verbose nil)
