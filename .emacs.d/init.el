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
                tab-width 4
                mode-line-format nil)
  (global-display-line-numbers-mode 1)
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (load-theme 'modus-vivendi :no-confirm))



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


(use-package pet
  :ensure t
  :config
  ;; Enable standard diagnostic tracking
  (add-hook 'python-base-mode-hook 'pet-mode -10))

(with-eval-after-load 'dape
  (add-to-list 'dape-configs
               `(uv-debugpy modes (python-mode python-ts-mode)
                         ;; Dynamically extract pet's calculated executable path
                         command ,(lambda () (or pet-python-executable "python"))
                         command-args ("-m" "debugpy.adapter" "--host" "0.0.0.0" "--port" :autoport)
                         :cwd dape-cwd
                         :program dape-buffer-default)))
  
;; uv environment management
;; (use-package uv-mode
;;  :hook 
;;  (python-base-mode . uv-mode))

(use-package dape
  :ensure t
  :config
  (dape-breakpoint-global-mode 1)
)

(use-package justl
  :ensure t
  :custom
  (justl-executable "C:/Users/mohan/.cargo/bin/just.exe"))

  
(use-package drag-stuff
  :ensure t
  :init
  (drag-stuff-global-mode 1)
  :config
  (drag-stuff-define-keys))



;; Requires project.el, which ships with Emacs since v28 (circa beginning 2022)
(defun my/project-root-or-default-dir ()
  (if-let ((proj (project-current)))
      (project-root proj)
    default-directory))

(defun setup-jai-mode ()
  (setq js-indent-level 4
        indent-tabs-mode nil)
  ;; This sets compile-command for compilation-mode - useful when you're compiling from Emacs.
  ;; jai-mode supports clicking on compile error messages to navigate directly to the source.
  (setq-local compile-command
              (concat "jai "
                      (let* ((root (my/project-root-or-default-dir))
                             (build-jai (concat root "build.jai"))
                             (main-jai (concat root "main.jai"))
                             (current-jai (buffer-file-name)))
                        (cond
                         ((file-exists-p build-jai) build-jai)
                         ((file-exists-p main-jai) main-jai)
                         (t current-jai))))))

(use-package jai-mode
  :defer t
  :straight (jai-mode :host github :repo "valignatev/jai-mode")
  :config
  :hook ((jai-mode-hook . setup-jai-mode)))







































;; Load custom keybindings

(add-to-list 'load-path (expand-file-name "user-emacs-directory" user-emacs-directory))
(load (expand-file-name "keybindings.el" user-emacs-directory))





