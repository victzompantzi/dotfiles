vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.api.nvim_set_keymap("i", "jk", "<Esc>v", {noremap=false})
vim.api.nvim_set_keymap("i", "kj", "<Esc>v", {noremap=false})
-- twilight
vim.api.nvim_set_keymap("n", "tw", ":Twilight<enter>", {noremap=false})
-- buffers
vim.api.nvim_set_keymap("n", "tk", ":blast<enter>", {noremap=false})
vim.api.nvim_set_keymap("n", "tj", ":bfirst<enter>", {noremap=false})
vim.api.nvim_set_keymap("n", "th", ":bprev<enter>", {noremap=false})
vim.api.nvim_set_keymap("n", "tl", ":bnext<enter>", {noremap=false})
vim.api.nvim_set_keymap("n", "td", ":bdelete<enter>", {noremap=false})
-- files
vim.api.nvim_set_keymap("n", "QQ", ":q!<enter>", {noremap=false})
vim.api.nvim_set_keymap("n", "<leader>wq", ":wq<enter>", {noremap=false})
vim.api.nvim_set_keymap("n", "E", "$", {noremap=false})
vim.api.nvim_set_keymap("n", "B", "^", {noremap=false})
vim.api.nvim_set_keymap("n", "TT", ":TransparentToggle<CR>", {noremap=true})
vim.api.nvim_set_keymap("n", "ss", ":noh<CR>", {noremap=true})
vim.api.nvim_set_keymap("i", "<C-e>", "<C-o>dw", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-j>", "a <CR>", {noremap=true})

--"<C-e>", "<C-o>dw", { desc = "Delete Word Forward"}, {noremap=true}
-- splits
--
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

vim.keymap.set("n", "<leader>ee", "<cmd>GoIfErr<cr>",
  {silent = true, noremap = true}
)

--My Keymaps VICTZ
vim.keymap.set("n", ";", ":", { desc = "CMD enter command mode" })
vim.api.nvim_set_keymap("n", "<F12>", ":SymbolsOutline<enter>", {noremap=false})
--vim.keymap.set("i", "<C-e>", "<C-o>dw", { desc = "Delete Word Forward"}, {noremap=true})
vim.keymap.set("n", "<down>", "gj")
vim.keymap.set("i", "<down>", "<C-o>gj")
vim.keymap.set("n", "<up>", "gk")
vim.keymap.set("i", "<up>", "<C-o>gk")
vim.api.nvim_set_keymap('n', 'p', ':lua require("nvim-clean-paste").custom_paste()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>1", ":TimerStart 1h<enter>", {noremap=false})
vim.keymap.set("n", "<ScrollWheelUp>", "<C-Y>", {noremap=false})
vim.keymap.set("n", "<ScrollWheelDown>", "<C-E>", {noremap=false})
vim.keymap.set( 'n', '<F10>', ':set spell!<CR>', { noremap = true, silent = true })
