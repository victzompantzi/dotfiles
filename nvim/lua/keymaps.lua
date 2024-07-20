vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.api.nvim_set_keymap("i", "jk", "<Esc>v", {noremap=false})
vim.api.nvim_set_keymap("i", "kj", "<Esc>v", {noremap=false})
-- twilight
vim.api.nvim_set_keymap("n", "tw", ":Twilight<enter>", {noremap=false})
-- buffers
vim.api.nvim_set_keymap("n", "mk", ":tabnext<enter>", {noremap=false})
vim.api.nvim_set_keymap("n", "mj", ":tabprevious<enter>", {noremap=false})
vim.api.nvim_set_keymap("n", "mh", ":bprev<enter>", {noremap=false})
vim.api.nvim_set_keymap("n", "ml", ":bnext<enter>", {noremap=false})
vim.api.nvim_set_keymap("n", "md", ":bdelete!<enter>", {noremap=false})
vim.api.nvim_set_keymap("n", "mc", ":tabclose<enter>", {noremap=false})
vim.api.nvim_set_keymap("n", "mn", ":tabnew<enter>", {noremap=false})
vim.api.nvim_set_keymap("n", "mt", ":tab term<enter>", {noremap=false})
-- files
vim.api.nvim_set_keymap("n", "E", "$", {noremap=false})
vim.api.nvim_set_keymap("n", "B", "^", {noremap=false})
vim.api.nvim_set_keymap("n", "TT", ":TransparentToggle<CR>", {noremap=true})
vim.api.nvim_set_keymap("n", "zx", ":%y+<CR>", {noremap=true})
vim.api.nvim_set_keymap("i", "<C-e>", "<C-o>dw", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-j>", "i<CR>", {noremap=true})

-- splits
vim.api.nvim_set_keymap("n", "<C-W>,", ":vertical resize -10<CR>", {noremap=true})
vim.api.nvim_set_keymap("n", "<C-W>.", ":vertical resize +10<CR>", {noremap=true})
vim.keymap.set('n', '<space><space>', "<cmd>set nohlsearch<CR>")
-- Quicker close split
--vim.keymap.set("n", "<leader>qq", ":q<CR>",
--{silent = true, noremap = true}
--)

-- Keymaps for better default experience
-- See `:help map()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Noice
--vim.api.nvim_set_keymap("n", "<leader>nn", ":Noice dismiss<CR>", {noremap=true})

--My Keymaps VICTZ
vim.keymap.set("n", ";", ":", { desc = "CMD enter command mode" })
vim.api.nvim_set_keymap("n", "<F12>", ":SymbolsOutline<enter>", {noremap=false})
--vim.keymap.set("i", "<C-e>", "<C-o>dw", { desc = "Delete Word Forward"}, {noremap=true})
vim.keymap.set("n", "<down>", "gj")
vim.keymap.set("n", "<up>", "gk")
vim.keymap.set("i", "<down>", "<C-o>gj")
vim.keymap.set("i", "<up>", "<C-o>gk")
-- ! Check if this keymap is still useful
vim.api.nvim_set_keymap('n', 'p', ':lua require("nvim-clean-paste").custom_paste()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>1", ":TimerStart 1h<enter>", {noremap=false})
vim.keymap.set("n", "<ScrollWheelUp>", "<C-Y>", {noremap=false})
vim.keymap.set("n", "<ScrollWheelDown>", "<C-E>", {noremap=false})
vim.keymap.set("n", "<C-s>", ":w<CR>", {noremap=false})
vim.keymap.set("n", "<A-up>", ":m -2<CR>", {noremap=false})
vim.keymap.set("n", "<A-down>", ":m +1<CR>", {noremap=false})
