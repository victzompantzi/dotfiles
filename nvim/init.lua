-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("transparent").clear_prefix("edgy")
require("transparent").clear_prefix("Barbecue")
require("transparent").clear_prefix("notify")
require("transparent").clear_prefix("WhichKey")
-- ! mason-lspconfig setup
require("mason").setup()
require("mason-lspconfig").setup({
  automatic_installation = false,
})

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
require("NeoColumn").setup()

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

-- ! Markdown-oxide
-- An example nvim-lspconfig capabilities setting
-- local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
--
-- -- Ensure that dynamicRegistration is enabled! This allows the LS to take into account actions like the
-- -- Create Unresolved File code action, resolving completions for unindexed code blocks, ...
-- capabilities.workspace = {
--   didChangeWatchedFiles = {
--     dynamicRegistration = true,
--   },
-- }

-- require("lspconfig").markdown_oxide.setup({
--   capabilities = capabilities, -- again, ensure that capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true
--   on_attach = on_attach, -- configure your on attach config
-- })
-- local cmp = require("cmp")
--
-- cmp.setup({
--   sources = cmp.config.sources({
--     {
--       name = "nvim_lsp",
--       option = {
--         markdown_oxide = { keyword_pattern = [[\(\k\| \|\/\|#\)\+]] },
--       },
--     },
--   }),
-- })
-- Obsidian Config
require("obsidian").setup({
  workspaces = {
    {
      name = "obsidian",
      path = "~/OneDrive/OneSyncFiles/Obsidian Vault",
    },
  },
  ui = { enable = false },
  sort_by = "modified",
  sort_reversed = true,
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
