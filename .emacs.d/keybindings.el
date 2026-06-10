;; Enable standard copy, cut, paste, and undo bindings
(cua-mode 1)
(global-set-key (kbd "C-s") 'save-buffer)         ; Ctrl+S to Save
(global-set-key (kbd "C-f") 'isearch-forward)     ; Ctrl+F to Find
(global-set-key (kbd "C-o") 'find-file)           ; Ctrl+O to Open file
(global-set-key (kbd "C-q") 'save-buffers-kill-terminal) ; Ctrl+Q to Quit

;;Micro keybindings
(keymap-global-set "C-s" 'save-buffer)                   
(keymap-global-set "C-f" 'isearch-forward ) 
(keymap-global-set "C-o" 'find-file )
(keymap-global-set "C-q" 'save-buffers-kill-terminal )
(keymap-global-set "M-a" 'move-beginning-of-line)
(keymap-global-set "M-e" 'move-end-of-line)
(keymap-global-set "C-<up>" 'beginning-of-buffer)
(keymap-global-set "C-<down>" 'end-of-buffer)


;; Define a custom function to kill the whole current line
(defun my-kill-whole-line ()
  "Delete the entire current line regardless of cursor position."
  (interactive)
  (beginning-of-line)
  (kill-line 1))

;; Bind Ctrl-k to the new function globally
(keymap-global-set "C-k" 'my-kill-whole-line)

;; Function to duplicate line below (using built-in Emacs 29+ function)
(defun my-duplicate-line-below ()
  "Duplicate the current line or region directly below."
  (interactive)
  (duplicate-line))

;; Function to duplicate line above
(defun my-duplicate-line-above ()
  "Duplicate the current line or region directly above."
  (interactive)
  (save-excursion
    (duplicate-line)))

(keymap-global-set "C-d" 'my-duplicate-line-below)
(keymap-global-set "C-S-d" 'my-duplicate-line-above)

;; Function to select the current line
(defun my-select-current-line ()
  "Select the entire current line."
  (interactive)
  (move-beginning-of-line 1)
  (push-mark nil nil t)
  (move-end-of-line 1))

;; Modern Emacs 29+ global keybinding
(keymap-global-set "C-l" 'my-select-current-line)
