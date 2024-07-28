-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Other interesting:
-- https://www.shortcutfoo.com/blog/top-50-vim-configuration-options
-- http://blog.ezyang.com/2010/03/vim-textwidth/
-- Add any additional options here
vim.opt.spelllang = { "es", "en" }
vim.opt.scrolloff = 999
vim.opt.cul = false
-- vim.opt.formatoptions = "tcro/nvjp"
vim.opt.formatoptions = "tcq"
vim.opt.pumblend = 0
-- vim.opt.wrap = true
-- vim.opt.linebreak = true
vim.opt.textwidth = 500
vim.opt.wm = 0
vim.opt.backspace = { "eol", "start", "indent" }
-- tw=0 fo=cqt wm=5:
-- vim.opt.whichwrap += { "<", ">", "h", "l" }
-- vim.opt.whichwrap = vim.opt.whichwrap + "<"
-- vim.opt.whichwrap = vim.opt.whichwrap + ">"
-- vim.opt.whichwrap = vim.opt.whichwrap + "h"
-- vim.opt.whichwrap = vim.opt.whichwrap + "l"
-- vim.opt.autoindent = false
-- vim.opt.cindent = false
-- vim.opt.smartindent = false
