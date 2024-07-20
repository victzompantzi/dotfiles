return {
  -- {
  --   "phaazon/hop.nvim",
  --   branch = "v2", -- optional but strongly recommended
  --   config = function()
  --     -- you can configure Hop the way you like here; see :h hop-config
  --     require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
  --   end,
  -- },
  {
    "minamorl/nvim-clean-paste",
  },
  {
    "epwalsh/pomo.nvim",
    version = "*", -- Recommended, use latest release instead of latest commit
    lazy = true,
    cmd = { "TimerStart", "TimerRepeat" },
    dependencies = {
      -- Optional, but highly recommended if you want to use the "Default" timer
      "rcarriga/nvim-notify",
    },
    opts = {
      notifiers = {
        -- The "Default" notifier uses 'vim.notify' and works best when you have 'nvim-notify' installed.
        {
          name = "Default",
          opts = {
            -- With 'nvim-notify', when 'sticky = true' you'll have a live timer pop-up
            -- continuously displayed. If you only want a pop-up notification when the timer starts
            -- and finishes, set this to false.
            sticky = false,

            -- Configure the display icons:
            title_icon = "⏳",
            text_icon = "⏱️",
            -- Replace the above with these if you don't have a patched font:
            -- title_icon = "⏳",
            -- text_icon = "⏱️",
          },
        },

        -- The "System" notifier sends a system notification when the timer is finished.
        -- Available on MacOS and Windows natively and on Linux via the `libnotify-bin` package.
        -- { name = "System" },

        -- You can also define custom notifiers by providing an "init" function instead of a name.
        -- See "Defining custom notifiers" below for an example 👇
        -- { init = function(timer) ... end }
      },
      -- See below for full list of options 👇
    },
  },
  {
    -- Barbecue
    -- https://github.com/utilyre/barbecue.nvim
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      -- https://github.com/SmiteshP/nvim-navic
      "SmiteshP/nvim-navic",
      -- https://github.com/nvim-tree/nvim-web-devicons
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
      -- configurations go here
      theme = "tokyonight-night",
    },
  },
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
      },
    },
  },
  {
    "stevearc/oil.nvim",
    opts = {},
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  },
  -- {
  --   "Pocco81/auto-save.nvim",
  --   config = function()
  --     require("auto-save").setup({
  --       -- your config goes here
  --       trigger_events = { "InsertLeave" },
  --       -- or just leave it empty :)
  --     })
  --   end,
  -- },
}
