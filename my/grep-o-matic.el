(require 'repository-root)
(require 'grep-o-matic)


(defconst repository-root-matcher/doo (cons 'repository-root-rule/root-dir-regexp "doo")
  "Matches the doo folder"
  )

(repository-root-add-builtin-matcher 'repository-root-matcher/doo)

(global-set-key (kbd "M-/")   'grep-o-matic-repository)

(global-set-key (kbd "C-`") 'next-error)
(global-set-key (kbd "C-/") 'previous-error)

