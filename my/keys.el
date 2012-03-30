(defun select-next-window ()
  "Switch to the next window"
  (interactive)
  (select-window (next-window)))

(defun select-previous-window ()
  "Switch to previous window"
  (interactive)
  (select-window (previous-window)))


(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank))

(let ((keys
       '(("C-x j"   . join-line)
	 ("M-n"     . forward-paragraph)
	 ("M-p"     . backward-paragraph)
	 ("C-z"     . ignore)
	 ("C-x C-z" . ignore)
	 ("C-M-w"   . copy-sexp)
         ("S-<up>" . windmove-up)
         ("S-<down>" . windmove-down)
         ("S-<right>" . windmove-right)
         ("S-<left>" . windmove-left)
         ("M-[" . select-previous-window)
         ("M-]" . select-next-window)
         ("C-x C-b" . ido-switch-buffer)
         ("C-S-<down>" . duplicate-line))))

  (dolist (key keys)
    (define-key (current-global-map)
      (read-kbd-macro (car key))
      (cdr key))))

;; Set command-key as M on MacOS
(setq mac-option-modifier 'none)
(setq mac-command-modifier 'meta)
