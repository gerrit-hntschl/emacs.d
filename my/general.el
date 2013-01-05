(setq-default kill-read-only-ok t)
(setq-default indent-tabs-mode nil)
(setq confirm-kill-emacs 'y-or-n-p)
(setq transient-mark-mode t)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(put 'downcase-region 'disabled nil)
(put 'set-goal-column 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(setq custom-file "~/.emacs.d/custom")
(load custom-file 'noerror)

(fset 'yes-or-no-p 'y-or-n-p)

(defadvice kill-ring-save (before slick-copy activate compile)
  "When called interactively with no active region, copy a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (message "Copied line")
     (list (line-beginning-position)
           (line-beginning-position 2)))))

(defadvice kill-region (before slick-cut activate compile)
  "When called interactively with no active region, kill a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
           (line-beginning-position 2)))))

(defun copy-sexp (&optional arg)
  "Copy a s-expression instead of killing it."
  (interactive "P")
  (save-excursion
    (toggle-read-only 1)
    (kill-sexp arg)
    (toggle-read-only 0)))

(setq frame-title-format
      (list '(buffer-file-name "%f" (dired-directory dired-directory "%b"))))

;; disable bloody graphical popups that block emacs forever when no default connection is set

(defadvice yes-or-no-p (around prevent-dialog activate)
  "Prevent yes-or-no-p from activating a dialog"
  (let ((use-dialog-box nil))
    ad-do-it))
(defadvice y-or-n-p (around prevent-dialog-yorn activate)
  "Prevent y-or-n-p from activating a dialog"
  (let ((use-dialog-box nil))
    ad-do-it))

;; try to set split-threshold to limit number of open windows caused by selecting grep results
;; default: (setq split-height-threshold 80)
;; default: (setq split-width-threshold 160)
(setq split-width-threshold 800)


