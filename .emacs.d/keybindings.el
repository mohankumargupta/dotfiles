;; Enable standard copy, cut, paste, and undo bindings
(cua-mode 1)
(global-set-key (kbd "C-s") 'save-buffer)         ; Ctrl+S to Save
(global-set-key (kbd "C-f") 'isearch-forward)     ; Ctrl+F to Find
(global-set-key (kbd "C-o") 'find-file)           ; Ctrl+O to Open file
(global-set-key (kbd "C-q") 'save-buffers-kill-terminal) ; Ctrl+Q to Quit

(keymap-global-set "C-s" 'save-buffer)                   
(keymap-global-set "C-f" 'isearch-forward ) 
(keymap-global-set "C-o" 'find-file )
(keymap-global-set "C-q" 'save-buffers-kill-terminal )
