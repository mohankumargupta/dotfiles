;; -*- lexical-binding: t -*-

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(setq use-package-always-ensure t)

(use-package emacs
  ;; 1. RUNS FIRST (Immediate Startup Settings)
  :init
  (setq inhibit-startup-screen t         ; Skip the welcome splash screen
        initial-scratch-message nil      ; Start with a blank *scratch* buffer
        use-short-answers t)             ; Change "yes/no" prompts to "y/n"

  ;; 2. CUSTOM SYSTEM VARIABLES (Standard User Preferences)
  :custom
  (xref-search-program 'ripgrep)
  (tab-always-indent 'complete)         ; Tab indents code, or completes if already indented
  (create-lockfiles nil)                ; Stop creating temporary .# files
  (make-backup-files nil)               ; Disable backup~ files (use Git instead)
  (text-scale-mode-step 1.1)            ; Make font zooming smooth

  ;; 3. KEYBINDINGS (Global Core Shortcuts)
  :bind
  ("C-c r" . (lambda () (interactive) (load-file user-init-file))) ; Quick reload config
  ("M-="   . text-scale-increase)       ; Quick zoom in
  ("M--"   . text-scale-decrease)       ; Quick zoom out

  ;; 4. HOOKS (Automated Event Triggers)
  :hook
  (before-save . delete-trailing-whitespace) ; Clean up whitespace on every save
  (prog-mode   . display-line-numbers-mode)  ; Turn on line numbers for all code

  ;; 5. RUNS LAST (Post-Initialization Changes)
  :config
  ;; Turn off visual clutter
  (tool-bar-mode -1)
  (menu-bar-mode -1)
  ;; Set the fallback indentation rules
  (setq-default tab-width 4
                indent-tabs-mode nil))  ; Use spaces instead of physical tabs

;;THEME
(use-package github-dark-vscode-theme
  :vc (:url "https://github.com/raspberrypisig/github-dark-vscode-emacs-theme"
       :rev :headline)
  :ensure t
  :config
  (load-theme 'github-dark-vscode t))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; syntax highlighting for python, rust et al
;; need to install tree-sitter from source
;; then compiled terminal emacs with:
;; ./configure --without-x --without-dbus --without-gconf \
;;             --without-gsettings --without-sound \
;;             --without-cairo --without-lcms2 \
;;             --without-jpeg --without-tiff \
;;             --without-gif --without-png \
;;             --without-rsvg --without-webp \
;;             --without-imagemagick --without-xml2 \
;;             --without-libsystemd --without-selinux \
;;             --without-gpm --without-kerberos \
;;             --without-kerberos5 --without-pop \
;;             --without-hesiod --without-mail-unlink \
;;             --disable-acl \
;;             --disable-x \
;;             --without-compress-install \
;;             --with-tree-sitter




(use-package treesit
  :ensure nil ; Built-in, no need to download
  :custom
  (treesit-auto-install-grammar 'always)
  (treesit-enabled-modes t))

(use-package eglot-python-preset
  :vc (:url "https://github.com/mwolson/eglot-python-preset"
       :main-file "eglot-python-preset.el"))

(use-package vertico
  :ensure t
  :init
  (vertico-mode)

  :config
  ;; Force Xref definitions to show in the Vertico minibuffer dropdown
  (setq xref-show-definitions-function #'xref-show-definitions-completing-read)

  ;; Optional: Force Xref references to also use Vertico minibuffer
  (setq xref-show-xrefs-function #'xref-show-definitions-completing-read)

  ;; Optional: Tweak minibuffer behavior for a smoother workflow
  (setq vertico-cycle t)           ; Cycle through the list seamlessly
  (setq vertico-resize nil))       ; Grow/shrink the window dynamically


(use-package corfu
  :ensure t
  :custom
  (corfu-auto t)                 ;; Enable auto completion as you type
  (corfu-cycle t)                ;; Enable cycling for keys like up/down/TAB
  (corfu-auto-delay 0.2)         ;; Brief delay before popup shows up
  (corfu-auto-prefix 2)          ;; Minimum number of characters to trigger auto-complete
  (corfu-quit-at-boundary 'separator) ;; Never quit at completion boundary
  :init
  (global-corfu-mode)           ;; Turn on Corfu everywhere
  ;; Direct Corfu-specific exact matching config
  (setq completion-category-defaults nil)
  (setq completion-category-overrides '((completion (styles basic)))))


