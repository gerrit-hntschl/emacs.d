;;(setq highlight-symbol-idle-delay 0)

(require 'highlight-symbol)

(add-hook 'emacs-lisp-mode-hook 'highlight-symbol-mode)
(add-hook 'clojure-mode-hook 'highlight-symbol-mode)
(setq highlight-symbol-on-navigation-p t)

;(global-set-key [(control #)] 'highlight-symbol-at-point)
;(global-set-key [f3] 'highlight-symbol-next)
;(global-set-key [(control ^)] 'highlight-symbol-prev)
;(global-set-key [(meta ^)] 'highlight-symbol-prev)
(global-set-key (kbd "C-&") 'highlight-symbol-next)
(global-set-key (kbd "C-*") 'highlight-symbol-prev)
