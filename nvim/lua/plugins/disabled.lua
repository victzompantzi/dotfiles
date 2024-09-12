return {
  -- disable headlines
  {
    "lukas-reineke/headlines.nvim",
    enabled = false,
  },
  -- lazy.nvim
  {
    "folke/noice.nvim",
    enabled = true,
    opts = {
      lsp = {
        progress = {
          enabled = false,
        },
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    enabled = true,
  },
  {
    "hrsh7th/nvim-cmp",
    enabled = true,
  },
  {
    -- Theming reference: https://github.com/meuter/lualine-so-fancy.nvim
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "meuter/lualine-so-fancy.nvim",
    },
    opts = {
      options = {
        theme = "horizon",
        component_separators = { left = "│", right = "│" },
        section_separators = { left = "", right = "" },
        globalstatus = true,
        refresh = {
          statusline = 100,
        },
      },
      sections = {
        lualine_a = {
          { "fancy_mode", width = 3 },
        },
        lualine_b = {
          { "fancy_branch" },
          { "fancy_diff" },
        },
        lualine_c = {},
        lualine_x = {
          function()
            local linters = require("lint").get_running()
            if #linters == 0 then
              return "󰦕"
            end
            return "󱉶 " .. table.concat(linters, ", ")
          end,
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
          { "fancy_diagnostics" },
          { "fancy_searchcount" },
          { "fancy_location" },
        },
        lualine_y = {
          { "fancy_filetype", ts_icon = "" },
        },
        lualine_z = {
          { "fancy_lsp_servers" },
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
    enabled = true,
  },
  {
    "nvim-treesitter-textobjects",
    enabled = true,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = true },
      servers = {},
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = true,
  },
  -- {
  --   "mfussenegger/nvim-lint",
  --   event = {
  --     "BufReadPre",
  --     "BufNewFile",
  --   },
  --   config = function()
  --     local lint = require("lint")
  --
  --     lint.linters_by_ft = {
  --       javascript = { "eslint_d" },
  --       typescript = { "eslint_d" },
  --       javascriptreact = { "eslint_d" },
  --       typescriptreact = { "eslint_d" },
  --       svelte = { "eslint_d" },
  --       kotlin = { "ktlint" },
  --       terraform = { "tflint" },
  --       ruby = { "standardrb" },
  --       markdown = { "markdownlint" },
  --     }
  --
  --     local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
  --
  --     vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  --       group = lint_augroup,
  --       callback = function()
  --         lint.try_lint()
  --       end,
  --     })
  --
  --     vim.keymap.set("n", "<leader>ci", function()
  --       lint.try_lint()
  --     end, { desc = "Trigger linting for current file" })
  --   end,
  -- },
  {
    "folke/flash.nvim",
    enabled = true,
  },
}
