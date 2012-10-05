(defun relative-to-source (file-name)
  (when file-name
    (let ((src (cadr (split-string file-name "src/"))))
          (if src
            src
            (let ((test-index (search "test/" file-name)))
                   (substring file-name (+ 5 test-index)))))))

(defun file-name->ns (file-name)
  (let ((src-resolved (relative-to-source file-name)))
    (when src-resolved
      (let* ((no-extension (replace-regexp-in-string ".clj$" "" src-resolved))
             (dots (replace-regexp-in-string "/" "." no-extension))
             (dashes (replace-regexp-in-string "_" "-" dots)))
        dashes))))

(defun insert-ns-decl ()
  "Creates the namespace based on the file-name of the current buffer.
   Assumes that the file path contains a src or test folder."
  (interactive)
  (if (= 0 (buffer-size))
      (let ((namespace (file-name->ns (buffer-file-name))))
        (when namespace
          (insert "(ns "
                  namespace
                  ")\n")))))

(add-hook 'clojure-mode-hook 'insert-ns-decl)
  

