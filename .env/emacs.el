; Don't forget to see README.md in this directory
; in order to install required packages using literate DevOps.

(add-to-list 'load-path (expand-file-name "~/.zsh/environments/elisp"))

(load "basic")

(my/info "Loading project-specific configuration.")

(load-theme 'adwaita)

; Support for Evil mode movement in 3rd party packages, such as Magit.
(evil-collection-init)

(defun my/local/tangle-org-mode-files ()
  (my/info "Running my/local/tangle-org-mode-files.")
  (org-babel-tangle))

(add-hook 'org-mode-hook
  (lambda ()
    (add-hook 'after-save-hook 'my/local/tangle-org-mode-files nil nil)))
