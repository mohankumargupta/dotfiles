;; Enable standard copy, cut, paste, and undo bindings
(cua-mode 1)
(global-set-key (kbd "C-s") 'save-buffer)         ; Ctrl+S to Save
(global-set-key (kbd "C-f") 'isearch-forward)     ; Ctrl+F to Find
(global-set-key (kbd "C-o") 'find-file)           ; Ctrl+O to Open file
(global-set-key (kbd "C-q") 'save-buffers-kill-terminal) ; Ctrl+Q to Quit

(keymap-global-set "C-/" 'comment-region )

(defun copy-line-to-clipboard ()
  "Select the entire current line, copy it to the clipboard, and deactivate the mark."
  (interactive)
  (let ((beg (line-beginning-position))
       (end (line-end-position)))
       (kill-ring-save beg end)
       (deactivate-mark)))
                          
(keymap-global-set "C-l" 'copy-line-to-clipboard )

(defun my-goto-first-line-start ()
  "Move cursor to the beginning of the first line in the buffer."
  (interactive)
  (goto-char (point-min))
  (beginning-of-line))

(defun my-goto-last-line-start ()
   "Move cursor to the beginning of the last line in the buffer."
   (interactive)
   (goto-char (point-max))
   (beginning-of-line))

(keymap-global-set "C-<up>" 'my-goto-first-line-start )
(keymap-global-set "C-<down>" 'my-goto-last-line-start )

(defun justl-run-recipe ()
 (interactive)
 (let ((justfile (justl--find-justfile default-directory)))
 (if justfile
     (let ((default-directory (file-name-directory justfile)))
     (compile (format "%s run" justl-executable)))
     (error "No justfile found in this directory tree"))))

(keymap-global-set "<f5>"     'justl-exec-default-recipe)
(keymap-global-set "<f6>"     #'justl-run-recipe)

;; this is used to exit f6, exiting f5 is simply q(minibuffer)
(defun force-clear-minibuffer ()
  (interactive)
  (when (active-minibuffer-window)
      (abort-recursive-edit)))

(keymap-global-set "C-<f9>" #'delete-other-windows)          




;;Micro keybindings
(keymap-global-set "C-s" 'save-buffer)                   
(keymap-global-set "C-f" 'isearch-forward ) 
(keymap-global-set "C-o" 'find-file )
(keymap-global-set "C-q" 'save-buffers-kill-terminal )
(keymap-global-set "M-a" 'move-beginning-of-line)
(keymap-global-set "M-e" 'move-end-of-line)
(keymap-global-set "C-<up>" 'beginning-of-buffer)
(keymap-global-set "C-<down>" 'end-of-buffer)

;;ibuffer
(keymap-global-set "C-x C-b" 'ibuffer)



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

(keymap-global-set "<f5>" 'dape)
(keymap-global-set "<f9>" 'dape-breakpoint-toggle)
(keymap-global-set "<f10>" 'dape-next)
(keymap-global-set "<f11>" 'dape-step-in)
(keymap-global-set "S-<f11>" 'dape-step-out)
;(keymap-global-set "C-c d c" 'dape-continue)
(keymap-global-set "C-<f9>" 'dape-quit)

(defun justl-run-recipe ()
 (interactive)
 (let ((justfile (justl--find-justfile default-directory)))
 (if justfile
     (let ((default-directory (file-name-directory justfile)))
     (compile (format "%s run" justl-executable)))
     (error "No justfile found in this directory tree"))))

(keymap-global-set "<f5>"     'justl-exec-default-recipe)
(keymap-global-set "<f6>"     #'justl-run-recipe)


(defun force-clear-minibuffer ()
  (interactive)
  (when (active-minibuffer-window)
      (abort-recursive-edit)))

(keymap-global-set "C-<f9>" #'delete-other-windows)          






