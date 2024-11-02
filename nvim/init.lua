-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
-- ! mason-lspconfig setup
-- require("mason").setup()
-- require("mason-lspconfig").setup({
--   automatic_installation = false,
-- })

-- After setting up mason-lspconfig you may set up servers via lspconfig
-- require("lspconfig").lua_ls.setup {}
-- require("lspconfig").rust_analyzer.setup {}
-- ...
-- -- initialize global var to false -> nvim-cmp turned off per default
vim.g.cmptoggle = false

local cmp = require("cmp")
cmp.setup({
  enabled = function()
    return vim.g.cmptoggle
  end,
})
vim.keymap.set("n", "<leader>ua", "<cmd>lua vim.g.cmptoggle = not vim.g.cmptoggle<CR>", { desc = "toggle nvim-cmp" })

--! ruff-lsp config
-- require("lspconfig").ruff.setup({
--   init_options = {
--     settings = {
--       -- Ruff language server settings go here
--     },
--   },
-- })
--
-- require("lspconfig").pyright.setup({
--   settings = {
--     pyright = {
--       -- Using Ruff's import organizer
--       disableOrganizeImports = true,
--     },
--     python = {
--       analysis = {
--         -- Ignore all files for analysis to exclusively use Ruff for linting
--         ignore = { "*" },
--       },
--     },
--   },
-- })

-- ! NeoColumn
require("NeoColumn").setup({})

-- Catpuccin
-- require("catppuccin").setup({
--   flavour = "mocha", -- latte, frappe, macchiato, mocha
--   background = { -- :h background
--     light = "latte",
--     dark = "mocha",
--   },
--   transparent_background = true,
-- })

-- ! Indent-blankline config
local highlight = {
  "RainbowRed",
  "RainbowYellow",
  "RainbowBlue",
  "RainbowOrange",
  "RainbowGreen",
  "RainbowViolet",
  "RainbowCyan",
}
local hooks = require("ibl.hooks")
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
  vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
  vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
  vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
  vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
  vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
  vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

--Disable indent-blankline at startup
require("ibl").update({
  enabled = false,
  indent = { highlight = highlight },
})

local hipatterns = require("mini.hipatterns")
hipatterns.setup({
  highlighters = {
    -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
    fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
    hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
    todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
    note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

    -- Highlight hex color strings (`#rrggbb`) using that color
    hex_color = hipatterns.gen_highlighter.hex_color(),
  },
})

-- Obsidian Config
require("obsidian").setup({
  workspaces = {
    {
      name = "obsidian",
      path = "~/OneDrive/OneSyncFiles/Obsidian Vault",
    },
  },
  ui = { enable = true },
  sort_by = "modified",
  sort_reversed = true,
  -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
  -- URL it will be ignored but you can customize this behavior here.
  ---@param url string
  follow_url_func = function(url)
    -- Open the URL in the default web browser.
    vim.cmd(':silent exec "!wsl-open ' .. url .. '"')
  end,
  -- Optional, by default when you use `:ObsidianFollowLink` on a link to an image
  -- file it will be ignored but you can customize this behavior here.
  ---@param img string
  follow_img_func = function(img)
    -- vim.fn.jobstart({ "qlmanage", "-p", img }) -- Mac OS quick look preview
    -- vim.fn.jobstart({ "xdg-open", url }) -- linux
    vim.cmd(':silent exec "!wsl-open ' .. url .. '"') -- Windows
  end,
})
require("noice").setup({
  presets = {
    -- you can enable a preset by setting it to true, or a table that will override the preset config
    -- you can also add custom presets that you can enable/disable with enabled=true
    bottom_search = true, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = false, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
  },
  views = {
    cmdline_popup = {
      position = {
        row = 5,
        col = "50%",
      },
      size = {
        width = 60,
        height = "auto",
      },
    },
    popupmenu = {
      relative = "editor",
      position = {
        row = 8,
        col = "50%",
      },
      size = {
        width = 60,
        height = 10,
      },
      border = {
        style = "rounded",
        padding = { 0, 1 },
      },
      win_options = {
        winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
      },
    },
  },
  lsp = { progress = { enabled = false } },
})
-- Running linters
-- Require("lint").get_running()
require("lint").linters_by_ft = {
  markdown = { "markdownlint" },
  -- Markdown = { "proselint" },
}
-- Require("hop").setup()
require("conform").setup({
  formatters_by_ft = {
    markdown = { "mdslw" },
  },
  formatters = {
    mdslw = {
      -- Env = {},
      prepend_args = { "--stdin-filepath", "$FILENAME" },
    },
  },
})
-- Null_ls
local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.completion.spell,
    null_ls.builtins.diagnostics.proselint,
    null_ls.builtins.code_actions.proselint,
    -- require("none-ls.diagnostics.eslint"), -- requires none-ls-extras.nvim
  },
})
-- Harper spell checker
-- require("lspconfig").harper_ls.setup({
--   settings = {
--     ["harper-ls"] = {
--       -- userDictPath = "~/dict.txt",
--       fileDictPath = "~/.config/harper-ls/",
--     },
--   },
-- })
-- require("render-markdown").setup({
--   heading = {
--     -- Turn on / off heading icon & background rendering
--     enabled = false,
--   },
-- })
-- require("menu").open(options, opts)
-- require("lspconfig").ltex.setup(config({
--   settings = {
--     ltex = {
--       language = "en",
--       -- additionalRules = {
--       --   languageModel = "~/models/ngrams/",
--       -- },
--     },
--   },
-- }))
require("transparent").clear_prefix("edgy")
require("transparent").clear_prefix("neo-tree")
require("transparent").clear_prefix("Barbecue")
require("transparent").clear_prefix("notify")
require("transparent").clear_prefix("WhichKey")
require("transparent").clear_prefix("lualine")
