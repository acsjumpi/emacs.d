;; Install use-package,in case it does not exist yet
;; The use-package software will install all other packages as required
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; ESS configurationEmacs Speaks Statistics
(use-package ess
  :ensure t
)

;; Auto completion
(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 2)
  (global-company-mode t)
)

; Parentheses
(use-package highlight-parentheses
  :ensure t
  :config
  (progn
    (highlight-parentheses-mode)
    (global-highlight-parentheses-mode))
  )

(provide 'init-r)
