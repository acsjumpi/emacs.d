;;; init-scala.el --- Support for the Scala language -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; Install use-package if not already installed
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

;; Enable defer and ensure by default for use-package
;; Keep auto-save/backup files separate from source code:  https://github.com/scalameta/metals/issues/1027
(setq use-package-always-defer t
      use-package-always-ensure t
      backup-directory-alist `((".*" . ,temporary-file-directory))
      auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

;; Enable scala-mode for highlighting, indentation and motion commands
(use-package scala-mode
             :mode "\\.s\\(cala\\|bt\\)$")

;; Enable sbt mode for executing sbt commands
(use-package sbt-mode
             :commands sbt-start sbt-command
             :config
             ;; WORKAROUND: https://github.com/ensime/emacs-sbt-mode/issues/31
             ;; allows using SPACE when in the minibuffer
             (substitute-key-definition
              'minibuffer-complete-word
              'self-insert-command
              minibuffer-local-completion-map)
             ;; sbt-supershell kills sbt-mode:  https://github.com/hvesalai/emacs-sbt-mode/issues/152
             (setq sbt:program-options '("-Dsbt.supershell=false"))
             )

;; Enable nice rendering of diagnostics like compile errors.
(use-package flycheck
             :init (global-flycheck-mode))

(use-package lsp-mode
  ;; Optional - enable lsp-mode automatically in scala files
  :hook  (scala-mode . lsp)
  (lsp-mode . lsp-lens-mode)
  :config (setq lsp-prefer-flymake nil))

;; Enable nice rendering of documentation on hover
(use-package lsp-ui)

;; lsp-mode supports snippets, but in order for them to work you need to use yasnippet
;; If you don't want to use snippets set lsp-enable-snippet to nil in your lsp-mode settings
;;   to avoid odd behavior with snippets and indentation
(use-package yasnippet)

;; Add company-lsp backend for metals
(use-package company-lsp)

(provide 'init-scala)

;;; init-scala.el ends here