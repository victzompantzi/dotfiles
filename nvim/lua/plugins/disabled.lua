return {
  -- disable headlines
  {
    "lukas-reineke/headlines.nvim",
    enabled = false,
  },
  {
    "folke/noice.nvim",
    enabled = false,
  },
  {
    "lewis6991/gitsigns.nvim",
    enabled = false,
  },
  {
    "hrsh7th/nvim-cmp",
    enabled = false,
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      sections = {
        lualine_c = {
          "diff",
          "diagnostics",
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
      },
    },
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
  },
}
