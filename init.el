(require 'cl)
(require 'package)

;;(add-to-list
;; 'package-archives
;; '("marmalade" . "http://marmalade-repo.org/packages/"))

(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)

(defvar prelude-packages
  '(clojure-mode gist haml-mode exec-path-from-shell
                   magit markdown-mode paredit 
                   yaml-mode zenburn-theme)
  "A list of packages to ensure are installed at launch.")

(defun prelude-packages-installed-p ()
  (loop for p in prelude-packages
        when (not (package-installed-p p)) do (return nil)
        finally (return t)))

(unless (prelude-packages-installed-p)
  ;; check for new packages (package versions)
  (message "%s" "Emacs Prelude is now refreshing its package database...")
  (package-refresh-contents)
  (message "%s" " done.")
  ;; install the missing packages
  (dolist (p prelude-packages)
    (when (not (package-installed-p p))
      (package-install p))))

(provide 'prelude-packages)

(add-to-list 'load-path "~/.emacs.d/lib")

(defun load-my (file)
  (load (concat "~/.emacs.d/my/" (symbol-name file))))

;; global
(load-my 'theme)
(load-my 'general)
(load-my 'auto-save)
(load-my 'keys)
(load-my 'scpaste)
;;(load-my 'hippie-expand)
(load-my 'browse-url)
(load-my 'smooth-scrolling)
(load-my 'anything)
(load-my 'printing)
(load-my 'grep-o-matic)

;; modes
;;(load-my 'highlight-parentheses)
(load-my 'highlight-symbol)
(load-my 'magit)
;;(load-my 'org)
;;(load-my 'ruby)
;;(load-my 'highline)

;; ido
(load-my 'ido)
(load-my 'ido-goto-symbol)

;;(load-my 'nrepl)

;; autocomplete
(load-my 'auto-complete)
;; (load-my 'ac-slime)

;; lisp
(load-my 'paredit)
;;(load-my 'elisp)
;;(load-my 'scheme)
;;(load-my 'chicken)
(load-my 'clojure)
(load-my 'clojurescript)
;;(load-my 'slime)
(load-my 'ide)
