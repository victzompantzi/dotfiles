-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("transparent").clear_prefix("edgy")
require("transparent").clear_prefix("Barbecue")
require("transparent").clear_prefix("notify")
require("transparent").clear_prefix("WhichKey")

-- -- initialize global var to false -> nvim-cmp turned off per default
vim.g.cmptoggle = false

local cmp = require("cmp")
cmp.setup({
  enabled = function()
    return vim.g.cmptoggle
  end,
})
vim.keymap.set("n", "<leader>ua", "<cmd>lua vim.g.cmptoggle = not vim.g.cmptoggle<CR>", { desc = "toggle nvim-cmp" })

-- ! ruff-lsp config
require("lspconfig").ruff.setup({
  init_options = {
    settings = {
      -- Ruff language server settings go here
    },
  },
})

require("lspconfig").pyright.setup({
  settings = {
    pyright = {
      -- Using Ruff's import organizer
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        -- Ignore all files for analysis to exclusively use Ruff for linting
        ignore = { "*" },
      },
    },
  },
})

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
-- ! Noice config
-- local noice = require("noice")
-- noice.setup({
--   lsp_progress = {
--     enabled = false,
--   },
-- })

-- ! Markview Config
-- local markview = require("markview")
-- local presets = require("markview.presets")
--
-- markview.setup({
--   headings = presets.headings.glow_labels,
--   modes = { "n", "no", "c" }, -- Change these modes
--   -- to what you need
--
--   hybrid_modes = { "n" }, -- Uses this feature on
--   -- normal mode
--
--   -- This is nice to have
--   callbacks = {
--     on_enable = function(_, win)
--       vim.wo[win].conceallevel = 0
--       vim.wo[win].conecalcursor = "c"
--     end,
--   },
-- })
--
-- vim.cmd("Markview enableAll")

-- ! Markdown-oxide
-- An example nvim-lspconfig capabilities setting
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Ensure that dynamicRegistration is enabled! This allows the LS to take into account actions like the
-- Create Unresolved File code action, resolving completions for unindexed code blocks, ...
capabilities.workspace = {
  didChangeWatchedFiles = {
    dynamicRegistration = true,
  },
}

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
