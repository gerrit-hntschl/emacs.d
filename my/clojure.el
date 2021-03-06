(autoload 'clojure-mode "clojure-mode" "Mode for editing Clojure source files")
(add-to-list 'auto-mode-alist '("\\.clj$" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.cljs$" . clojure-mode))

(add-hook 'clojure-mode-hook
          (lambda () 
            (show-paren-mode t)
            (paredit-mode t)
            ;;(highlight-parentheses-mode t)
))

(eval-after-load 'clojure-mode
  '(define-clojure-indent
     (describe 'defun)
     (testing 'defun)
     (feature 'defun)
     (scenario 'defun)
     (given 'defun)
     (using 'defun)
     (with 'defun)
     (it 'defun)
     (do-it 'defun)
     (let-uri-parts 'defun)))


;; slime
;;(eval-after-load 'slime
;;  '(progn (slime-setup '(slime-repl))))

(require 'clojure-mode)
(defun define-function ()
  (interactive)
  (let ((name (symbol-at-point)))
    (backward-paragraph)
    (insert "\n(defn " (symbol-name name) "\n [])\n" )
    (backward-char 3)))

(define-key clojure-mode-map (kbd "M-RET") 'define-function)
