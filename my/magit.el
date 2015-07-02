(require 'exec-path-from-shell)

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(global-set-key (kbd "C-c i") 'magit-status)
