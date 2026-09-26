-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here


-- Ctrl+C to Copy (Yank) in Visual Mode
vim.keymap.set("v", "<C-c>", '"+y', { noremap = true, silent = true, desc = "CUA: Copy to Clipboard" })

-- Ctrl+X to Cut in Visual Mode
vim.keymap.set("v", "<C-x>", '"+x', { noremap = true, silent = true, desc = "CUA: Cut to Clipboard" })

-- Ctrl+V to Paste in Insert and Command Modes
vim.keymap.set("i", "<C-v>", '<C-r>+', { noremap = true, silent = true, desc = "CUA: Paste from Clipboard" })
vim.keymap.set("c", "<C-v>", '<C-r>+', { noremap = true, silent = true, desc = "CUA: Paste from Clipboard" })

-- Ctrl+V to Paste in Normal and Visual Modes (replacing selection)
vim.keymap.set("n", "<C-v>", '"+gP', { noremap = true, silent = true, desc = "CUA: Paste from Clipboard" })
vim.keymap.set("v", "<C-v>", '"_d"+gP', { noremap = true, silent = true, desc = "CUA: Paste over selection" })

-- Ctrl+A to Select All (Normal, Visual, and Insert Modes)
vim.keymap.set("n", "<C-a>", "ggVG", { noremap = true, silent = true, desc = "CUA: Select All" })
vim.keymap.set("v", "<C-a>", "<Esc>ggVG", { noremap = true, silent = true, desc = "CUA: Select All" })
vim.keymap.set("i", "<C-a>", "<Esc>ggVG", { noremap = true, silent = true, desc = "CUA: Select All" })

-- Ctrl+Z to Undo
vim.keymap.set({"n", "i", "v"}, "<C-z>", "<Cmd>undo<CR>", { noremap = true, silent = true, desc = "CUA: Undo" })

-- Ctrl+Y to Redo
vim.keymap.set({"n", "i", "v"}, "<C-y>", "<Cmd>redo<CR>", { noremap = true, silent = true, desc = "CUA: Redo" })

-- Move current line down/up in Normal mode
-- vim.keymap.del("n", "K")
-- 2. Map Shift+J and Shift+K to move lines up and down (Normal Mode)

-- vim.keymap.set("n", "<C-,>", "<cmd>m .+1<cr>===", { desc = "Move line down" })
-- vim.keymap.set("n", "<C-.", "<cmd>m .-2<cr>===", { desc = "Move line up" })

-- vim.keymap.set("n", "k", "<cmd>m .-2<cr>==", { desc = "Move line up" })
-- vim.keymap.set("n", "j", "<cmd>m .+1<cr>==", { desc = "Move line down" }

vim.keymap.set({"n"}, "<C-l>" , function()
 Snacks.terminal.toggle(nil, {
    win = {
      position = "right",
      width = 0.5,
    }
  })
end, {desc = "open terminal"})

vim.keymap.set("t", "<C-q>", function()
  if vim.bo.filetype ~= "snacks_terminal" then
    return vim.api.nvim_replace_termcodes("<C-q>", true, false, true)
  end
  local term = Snacks.terminal.get(nil, { create = false })
  if term then
    term:hide()
  end
end, { expr = true, desc = "Hide terminal" })
