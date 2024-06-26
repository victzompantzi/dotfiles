require('keymaps')
require('plugins.lazy')
require('plugins.misc')
require('plugins.lualine')
require('options')
require('misc')
require('plugins.gitsigns')
require('plugins.tele')
require('plugins.treesitter')
require('plugins.lsp')
require('plugins.zenmode')
require('plugins.neogit')
require("symbols-outline").setup()
--Barbecue Options
require("barbecue").setup {
    theme = "catppuccin-mocha", -- catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
  }
--Transparent Setup
  require("transparent").setup({ -- Optional, you don't have to run setup.
  groups = { -- table: default groups
    'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
    'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
    'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
    'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
    'EndOfBuffer',
  },

  extra_groups = {
    "SymbolsOutline",
    "Lualine",
    "Barbecue",
  },
   -- table: additional groups that should be cleared
  exclude_groups = {}, -- table: groups you don't want to clear
})

--Which Key
local wk = require("which-key")
wk.register(mappings, opts)
--require('leap').create_default_mappings()
-- vim: ts=8 sts=2 sw=2 et
local hop = require('hop')
local directions = require('hop.hint').HintDirection
vim.keymap.set('', 'f', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
end, {remap=true})
vim.keymap.set('', 'F', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end, {remap=true})
vim.keymap.set('', 't', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
end, {remap=true})
vim.keymap.set('', 'T', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
end, {remap=true})

--require('lualine').setup {
--  options = {
--    -- For more themes, see https://github.com/nvim-lualine/lualine.nvim/blob/master/THEMES.md
--    theme = "catppuccin", -- "auto, tokyonight, catppuccin, codedark, nord"
--  },
--  sections = {
--    lualine_c = {
--      {
--        -- Customize the filename part of lualine to be parent/filename
--        'filename',
--        file_status = true,      -- Displays file status (readonly status, modified status)
--        newfile_status = false,  -- Display new file status (new file means no write after created)
--        path = 1,                -- 0: Just the filename
--                                 -- 1: Relative path
--                                 -- 2: Absolute path
--                                 -- 3: Absolute path, with tilde as the home directory
--                                 -- 4: Filename and parent dir, with tilde as the home directory
--        symbols = {
--          modified = '[+]',      -- Text to show when the file is modified.
--          readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
--        }
--      }
--    },
--    lualine_x = {
--    function()
--      local ok, pomo = pcall(require, "pomo")
--      if not ok then
--        return ""
--      end
--
--      local timer = pomo.get_first_to_finish()
--      if timer == nil then
--        return ""
--      end
--
--      return "󰄉 " .. tostring(timer)
--    end,
--    "encoding",
--    "fileformat",
--    "filetype",
--  },
--  }
--}

require("auto-save").setup
{
  {
     enabled = true, -- start auto-save when the plugin is loaded (i.e. when your package manager loads it)
      -- execution_message = {
      -- message = function() -- message to print on save
      --   return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
      -- end,
      -- dim = 0.18, -- dim the color of `message`
      -- cleaning_interval = 0, -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
      --},
     trigger_events = {"InsertLeave", "TextChanged"}, -- vim events that trigger auto-save. See :h events
   -- function that determines whether to save the current buffer or not
   -- return true: if buffer is ok to be saved
   -- return false: if it's not ok to be saved
   condition = function(buf)
     local fn = vim.fn
     local utils = require("auto-save.utils.data")

     if
       fn.getbufvar(buf, "&modifiable") == 1 and
       utils.not_in(fn.getbufvar(buf, "&filetype"), {}) then
       return true -- met condition(s), can save
     end
     return false -- can't save
   end,
     write_all_buffers = false, -- write all buffers when the current one meets `condition`
     debounce_delay = 135, -- saves the file at most every `debounce_delay` milliseconds
   callbacks = { -- functions to be executed at different intervals
     enabling = nil, -- ran when enabling auto-save
     disabling = nil, -- ran when disabling auto-save
     before_asserting_save = nil, -- ran before checking `condition`
     before_saving = nil, -- ran before doing the actual save
     after_saving = nil -- ran after doing the actual save
    },
  }
}
require("oil").setup()
--require("precognition").toggle()
