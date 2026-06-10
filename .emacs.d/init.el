;; Straight.el

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(setq straight-use-package-by-default t)

;; General settings

(use-package emacs
  :init
  (setq use-answers t)
  :config
  (setq-default truncate-lines t
                display-line-numbers-width 3
                indent-tabs-mode nil
                fill-column 100
                tab-width 4
                mode-line-format nil)
  (global-display-line-numbers-mode 1)
  (menu-bar-mode -1)
  (tool-bar-mode -1))


;; AutoCompletion

(use-package corfu
    :init
    (global-corfu-mode)
    :config
    (setq corfu-auto t
          corfu-echo-documentation t
          corfu-scroll-margin 0
          corfu-count 8
          corfu-max-width 50
          corfu-min-width corfu-max-width
          corfu-auto-prefix 2))

(use-package corfu-terminal
  :hook
  (corfu-mode . corfu-terminal-mode)
)

(use-package eglot
  :ensure t 
  :config
  ;; Tell Eglot to use the globally exposed rass tool for Python
  (add-to-list 'eglot-server-programs '((python-mode python-ts-mode) . 
               ("rass" "python"))))
;; Automatically spin up Eglot and format your code on-save
(add-hook 'python-base-mode-hook (lambda () (eglot-ensure) (add-hook 
            'after-save-hook #'eglot-format nil t)))
(add-hook 'eglot-managed-mode-hook #'eglot-inlay-hints-mode)
  


;; Load custom keybindings

(add-to-list 'load-path (expand-file-name "user-emacs-directory" user-emacs-directory))
(load (expand-file-name "keybindings.el" user-emacs-directory))
