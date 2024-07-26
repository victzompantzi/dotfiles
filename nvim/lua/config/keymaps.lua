-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.api.nvim_set_keymap("i", "jk", "<Esc>", { noremap = false })
vim.api.nvim_set_keymap("n", "<leader>0", ":%y+<CR>", { noremap = true })
vim.api.nvim_set_keymap("i", "<C-d>", "<C-o>dw", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-j>", "a<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<F12>", ":Outline<enter>", { noremap = false })
vim.api.nvim_set_keymap(
  "n",
  "p",
  ':lua require("nvim-clean-paste").custom_paste()<CR>',
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n", "<leader>1", ":TimerStart 1h<enter>", { noremap = false })
vim.api.nvim_set_keymap("n", "<leader>2", ":TimerStart 30m<enter>", { noremap = false })
--vim.keymap.set("n", "<A-up>", ":m -2<CR>", { noremap = false })
--vim.keymap.set("n", "<A-down>", ":m +1<CR>", { noremap = false })
vim.keymap.set("i", "<down>", "<C-o>gj")
vim.keymap.set("i", "<up>", "<C-o>gk")
vim.keymap.set("n", "<C-z>", "u")
vim.keymap.set("i", "<C-z>", "<C-o>u")
vim.keymap.set("n", "<C-y>", "<C-r>")
vim.keymap.set("i", "<C-y>", "<C-o><C-r>")
-- local hop = require("hop")
-- local directions = require("hop.hint").HintDirection
-- vim.keymap.set("", "f", function()
--   hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
-- end, { remap = true })
-- vim.keymap.set("", "F", function()
--   hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
-- end, { remap = true })
-- vim.keymap.set("", "t", function()
--   hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
-- end, { remap = true })
-- vim.keymap.set("", "T", function()
--   hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
-- end, { remap = true })
