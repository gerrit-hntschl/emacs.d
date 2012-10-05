(require 'paredit)

(defun backward-up-list+-1 ()
  "go to left of )"
  (interactive)
  (backward-up-list)
  (forward-char))
(define-key lisp-mode-shared-map (kbd "C-M-9") 'backward-up-list+-1)

(defun up-list+-1 ()
  "go to right of ("
  (interactive)
  (up-list)
  (backward-char))
(define-key lisp-mode-shared-map (kbd "C-M-0") 'up-list+-1)
