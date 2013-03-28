(add-hook 'nrepl-interaction-mode-hook
  'nrepl-turn-on-eldoc-mode)

(require 'ac-nrepl)
(add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
(add-hook 'nrepl-interaction-mode-hook 'ac-nrepl-setup)
(add-hook 'nrepl-mode-hook 'paredit-mode)

(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'nrepl-mode))

(define-key nrepl-interaction-mode-map (kbd "C-q") 'ac-nrepl-popup-doc)

(global-set-key (kbd "M-n") 'nrepl-set-ns)

(define-key nrepl-mode-map (kbd "M-R") 'nrepl-previous-matching-input)

(defun nrepl-connection-infos (connection-buffer)
  (with-current-buffer (get-buffer connection-buffer)
    nrepl-endpoint))

(defun nrepl-current-connection-infos ()
  (nrepl-connection-infos (nrepl-current-connection-buffer)))

(defun nrepl-rotate-connection-list (connection-list)
  (append (rest connection-list)
          (list (first connection-list))))

(defun nrepl-show-current-connection ()
  (apply #'message
         "Active nrepl connection: Host=%s Port=%s"
         (nrepl-current-connection-infos)))

(defun nrepl-switch-to-next-connection ()
  (interactive)
  (setq nrepl-connection-list
        (nrepl-rotate-connection-list nrepl-connection-list))
  (nrepl-show-current-connection))

(global-set-key (kbd "C-c C-x n") 'nrepl-switch-to-next-connection)

(defun nrepl-define-connect-keys ()
  (dolist (n (number-sequence 1 9))
    (let ((k (concat "C-c " (number-to-string n))))
      (define-key (current-global-map)
        (read-kbd-macro k)
        (lexical-let ((port (+ 4004 n)))
          (lambda (arg)
            (interactive "P")
            (let* ((conn (find port
                               (nrepl-connection-buffers)
                               :test (lambda (port conn)
                                       (= port (cadr (nrepl-connection-infos (get-buffer conn)))))))
                   (conn (or conn (process-buffer (nrepl-connect "127.0.0.1" port)))))
              (nrepl-make-repl-connection-default conn)
              (let ((nrepl-connection-buffer conn))
                (nrepl-switch-to-repl-buffer arg))
              (nrepl-show-current-connection))))))))

(nrepl-define-connect-keys)

;;(add-hook 'nrepl-interaction-mode-hook 'my-nrepl-mode-setup)
;;(defun my-nrepl-mode-setup ()
;;  (require 'nrepl-ritz))

