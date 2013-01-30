(setq org-publish-project-alist
      '(("blog"
         :base-directory "~/prg/org/blog"
         :publishing-directory "~/prg/org/blog/html"
         ;; :publishing-function (org-publish-org-to-html
         ;;                       org-publish-org-to-pdf)
         :section-numbers t
         :table-of-contents t
         :footnotes t
         :auto-sitemap t
         :sitemap-filename "index.org"
         :sitemap-title "klutometis' daybook (\u03c4\u03bf\u1fe6 \u1f10\u03c6\u03b7\u03bc\u03b5\u03c1\u03af\u03c2 \u03ba\u03bb\u03c5\u03c4\u03bf\u03bc\u03ae\u03c4\u03b9\u03b4\u03bf\u03c2)"
         :author "Peter Danenberg"
         :email "pcd@wikitex.org"
         :exclude "draft.*"
         :style "<link rel=\"stylesheet\" type=\"text/css\"/ href=\"daybook.css\">"
         :html-table-tag "<table rules=\"groups\" frame=\"hsides\" cellpadding=\"6\">"
         )))
