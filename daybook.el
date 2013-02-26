(defun publish-org-sitemap-as-table (project &optional sitemap-filename)
  "Create a sitemap of pages in set defined by PROJECT.
Optionally set the filename of the sitemap with SITEMAP-FILENAME.
Default for SITEMAP-FILENAME is 'sitemap.org'."
  (let* ((project-plist (cdr project))
         (dir (file-name-as-directory
               (plist-get project-plist :base-directory)))
         (exclude-regexp (plist-get project-plist :exclude))
         (files (nreverse (org-publish-get-base-files project exclude-regexp)))
         (sitemap-filename (concat dir (or sitemap-filename "sitemap.org")))
         (sitemap-title (or (plist-get project-plist :sitemap-title)
                            (concat "Sitemap for project " (car project))))
         (sitemap-style (or (plist-get project-plist :sitemap-style)
                            'tree))
         (sitemap-sans-extension (plist-get project-plist :sitemap-sans-extension))
         (visiting (find-buffer-visiting sitemap-filename))
         (ifn (file-name-nondirectory sitemap-filename))
         file sitemap-buffer)
    (with-current-buffer (setq sitemap-buffer
                               (or visiting (find-file sitemap-filename)))
      (erase-buffer)
      (insert (concat "#+TITLE: " sitemap-title "\n\n"))
      (insert "#+ATTR_HTML: frame=\"void\" rules=\"none\" class=\"toc\"\n")
      (while (setq file (pop files))
        (let ((fn (file-name-nondirectory file))
              (link (file-relative-name file dir)))
          (when sitemap-sans-extension
            (setq link (file-name-sans-extension link)))
          (unless (equal (file-truename sitemap-filename)
                         (file-truename file))
            (insert (concat "| "
                            "[[file:" link "]["
                            (org-publish-find-title file)
                            "]]"
                            " | "
                            (format-time-string
                             org-sitemap-date-format
                             (org-publish-find-date file))
                            " |\n")))))
      (save-buffer))
    (or visiting (kill-buffer sitemap-buffer))))

(setq org-publish-project-alist
      '(("daybook-static"
         :base-directory "~/prg/org/daybook/static"
         :publishing-directory "~/prg/org/daybook/html"
         :base-extension any
         :publishing-function org-publish-attachment)
        ("daybook-content"
         :base-directory "~/prg/org/daybook/org"
         :publishing-directory "~/prg/org/daybook/html"
         :section-numbers t
         :table-of-contents t
         :footnotes t
         :auto-sitemap t
         :sitemap-filename "index.org"
         :sitemap-title "klutometis’ daybook"
         :author "Peter Danenberg"
         :email "pcd@wikitex.org"
         :exclude "\\(TODO\\|draft.*\\)\\.org"
         :style "<link rel=\"stylesheet\" type=\"text/css\"/ href=\"daybook.css\"><link href='http://fonts.googleapis.com/css?family=Cardo' rel='stylesheet' type='text/css'>"
         :html-table-tag "<table rules=\"groups\" frame=\"hsides\" cellpadding=\"6\">"
         :html-postamble nil
         :sitemap-date-format "‘%y %B %d"
         :sitemap-sort-files anti-chronologically
         :sitemap-function publish-org-sitemap-as-table)
        ("daybook" :components ("daybook-static" "daybook-content"))))
