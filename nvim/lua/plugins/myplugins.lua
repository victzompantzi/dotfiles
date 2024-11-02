return {
  -- {
  --   "smoka7/hop.nvim",
  --   version = "*",
  --   opts = {
  --     keys = "etovxqpdygfblzhckisuran",
  --   },
  -- },
  -- { "pocco81/auto-save.nvim" },
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
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
      -- configurations go here
      theme = "rose-pine",
    },
  },
  -- {
  --   "neovim/nvim-lspconfig",
  --   ---@class PluginLspOpts
  --   opts = {
  --     ---@type lspconfig.options
  --     servers = {
  --       -- pyright will be automatically installed with mason and loaded with lspconfig
  --     },
  --   },
  -- },
  -- Lua
  {
    "folke/zen-mode.nvim",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      window = {
        backdrop = 1, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
        -- height and width can be:
        -- * an absolute number of cells when > 1
        -- * a percentage of the width / height of the editor when <= 1
        -- * a function that returns the width or the height
        width = 90,
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "rose-pine",
    },
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  { "xiyaowong/transparent.nvim" },
  -- {
  --   "ibhagwan/fzf-lua",
  --   -- optional for icon support
  --   dependencies = { "nvim-tree/nvim-web-devicons" },
  --   config = function()
  --     -- calling `setup` is optional for customization
  --     require("fzf-lua").setup({})
  --   end,
  -- },
  -- -- lazy.nvim:
  {
    "smoka7/multicursors.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvimtools/hydra.nvim",
    },
    opts = {},
    cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
    keys = {
      {
        mode = { "v", "n" },
        "<Leader>m",
        "<cmd>MCstart<cr>",
        desc = "Create a selection for selected text or word under the cursor",
      },
    },
  },
  {
    "sindrets/diffview.nvim",
  },
  -- {
  --   "OXY2DEV/markview.nvim",
  --   lazy = false, -- Recommended
  --   -- ft = "markdown" -- If you decide to lazy-load anyway
  --
  --   dependencies = {
  --     -- You will not need this if you installed the
  --     -- parsers manually
  --     -- Or if the parsers are in your $RUNTIMEPATH
  --     "nvim-treesitter/nvim-treesitter",
  --
  --     "nvim-tree/nvim-web-devicons",
  --   },
  -- },
  {
    "epwalsh/obsidian.nvim",
    requires = {
      -- Required.
      "nvim-lua/plenary.nvim",
      -- see below for full list of optional dependencies 👇
    },
  },
  {
    "ecthelionvi/NeoColumn.nvim",
    opts = {},
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  -- {
  --   "andrewferrier/wrapping.nvim",
  --   config = function()
  --     require("wrapping").setup()
  --   end,
  -- },
  -- { "gitaarik/nvim-cmp-toggle" },
  -- {
  --   "williamboman/mason.nvim",
  --   "williamboman/mason-lspconfig.nvim",
  --   "neovim/nvim-lspconfig",
  -- },
  -- { "ellisonleao/glow.nvim", config = true, cmd = "Glow" },
  -- { "razziel89/mdslw" },
  -- {
  --   "MeanderingProgrammer/render-markdown.nvim",
  --   opts = {},
  --   -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
  --   -- dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" }, -- if you use standalone mini plugins
  --   dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
  -- },
  ---@type LazySpec
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
      -- 👇 in this section, choose your own keymappings!
      {
        "<leader>-",
        "<cmd>Yazi<cr>",
        desc = "Open yazi at the current file",
      },
      {
        -- Open in the current working directory
        "<leader>cw",
        "<cmd>Yazi cwd<cr>",
        desc = "Open the file manager in nvim's working directory",
      },
      {
        -- NOTE: this requires a version of yazi that includes
        -- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
        "<c-up>",
        "<cmd>Yazi toggle<cr>",
        desc = "Resume the last yazi session",
      },
    },
    ---@type YaziConfig
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = false,
      keymaps = {
        show_help = "<f1>",
      },
    },
  },
  -- {
  --   "jake-stewart/multicursor.nvim",
  --   config = function()
  --     local mc = require("multicursor-nvim")
  --
  --     mc.setup()
  --
  --     -- use MultiCursorCursor and MultiCursorVisual to customize
  --     -- additional cursors appearance
  --     vim.cmd.hi("link", "MultiCursorCursor", "Cursor")
  --     vim.cmd.hi("link", "MultiCursorVisual", "Visual")
  --
  --     vim.keymap.set("n", "<F2>", function()
  --       if mc.hasCursors() then
  --         mc.clearCursors()
  --       else
  --         -- default <esc> handler
  --       end
  --     end)
  --
  --     -- add cursors above/below the main cursor
  --     vim.keymap.set("n", "<up>", function()
  --       mc.addCursor("k")
  --     end)
  --     vim.keymap.set("n", "<down>", function()
  --       mc.addCursor("j")
  --     end)
  --
  --     -- add a cursor and jump to the next word under cursor
  --     vim.keymap.set("n", "<c-n>", function()
  --       mc.addCursor("*")
  --     end)
  --
  --     -- jump to the next word under cursor but do not add a cursor
  --     vim.keymap.set("n", "<c-s>", function()
  --       mc.skipCursor("*")
  --     end)
  --
  --     -- add and remove cursors with control + left c
  --     vim.keymap.set("n", "<c-leftmouse>", mc.handleMouse)
  --   end,
  -- },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  -- { "nvchad/volt", lazy = true },
  -- { "nvchad/menu", lazy = true },
  -- { "meuter/lualine-so-fancy.nvim" },
  {
    "lervag/vimtex",
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_view_method = "zathura"
    end,
  },
  -- {
  --   "iurimateus/luasnip-latex-snippets.nvim",
  --   -- vimtex isn't required if using treesitter
  --   requires = { "L3MON4D3/LuaSnip", "lervag/vimtex" },
  --   config = function()
  --     require("luasnip-latex-snippets").setup()
  --     -- or setup({ use_treesitter = true })
  --     require("luasnip").config.setup({ enable_autosnippets = true })
  --   end,
  -- },
}
