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
  
  ;; Set the fallback indentation rules
  (setq-default tab-width 4
                indent-tabs-mode nil))  ; Use spaces instead of physical tabs



