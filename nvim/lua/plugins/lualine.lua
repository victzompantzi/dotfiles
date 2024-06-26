require('lualine').setup {
  options = {
    -- For more themes, see https://github.com/nvim-lualine/lualine.nvim/blob/master/THEMES.md
    theme = "tokyonight", -- "auto, tokyonight, catppuccin, codedark, nord"
  },
  sections = {
    lualine_c = {
      {
        -- Customize the filename part of lualine to be parent/filename
        'filename',
        file_status = true,      -- Displays file status (readonly status, modified status)
        newfile_status = false,  -- Display new file status (new file means no write after created)
        path = 1,                -- 0: Just the filename
                                 -- 1: Relative path
                                 -- 2: Absolute path
                                 -- 3: Absolute path, with tilde as the home directory
                                 -- 4: Filename and parent dir, with tilde as the home directory
        symbols = {
          modified = '[+]',      -- Text to show when the file is modified.
          readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
        }
      }
    },
    lualine_x = {
    function()
      local ok, pomo = pcall(require, "pomo")
      if not ok then
        return ""
      end

      local timer = pomo.get_first_to_finish()
      if timer == nil then
        return ""
      end

      return "󰄉 " .. tostring(timer)
    end,
    "encoding",
    "fileformat",
    "filetype",
  },
  }
}

--require('lualine').setup {
--  options = {
--    icons_enabled = true,
--    component_separators = '|',
--    section_separators = '',
--  },
--  sections = {
--    lualine_x = {
--      {
--        require("noice").api.statusline.mode.get,
--        cond = require("noice").api.statusline.mode.has,
--        color = { fg = "#ff9e64" },
--      },
--      {
--        require("noice").api.status.command.get,
--        cond = require("noice").api.status.command.has,
--        color = { fg = "#ff9e64" },
--      },
--    },
--    lualine_a = {
--      {
--        'buffers',
--      }
--    }
--  }
--}
--
--