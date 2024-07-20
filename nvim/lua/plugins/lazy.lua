-- Install lazylazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Fixes Notify opacity issues
vim.o.termguicolors = true

require("lazy").setup({
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration
			"nvim-telescope/telescope.nvim", -- optional
		},
		config = true,
	},
	"onsails/lspkind.nvim",
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	"preservim/vim-pencil",
	{
		"sourcegraph/sg.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	"folke/zen-mode.nvim",
	"tpope/vim-obsession",
	-- Tree
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		requires = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup({})
		end,
	},
	-- Database
	"kristijanhusak/vim-dadbod-ui",
	"kristijanhusak/vim-dadbod-completion",
	{
		"tpope/vim-dadbod",
		opt = true,
		requires = {
			"kristijanhusak/vim-dadbod-ui",
			"kristijanhusak/vim-dadbod-completion",
		},
		config = function()
			require("config.dadbod").setup()
		end,
	},

	"ThePrimeagen/git-worktree.nvim",
	"tpope/vim-surround",
	"xiyaowong/nvim-transparent",
	{
		"numToStr/FTerm.nvim",
		config = function()
			local map = vim.api.nvim_set_keymap
			local opts = { noremap = true, silent = true }
			require("FTerm").setup({
				blend = 5,
				dimensions = {
					height = 0.90,
					width = 0.90,
					x = 0.5,
					y = 0.5,
				},
			})
		end,
	},

	{
		"rmagatti/goto-preview",
		config = function()
			require("goto-preview").setup({
				width = 120, -- Width of the floating window
				height = 15, -- Height of the floating window
				border = { "↖", "─", "┐", "│", "┘", "─", "└", "│" }, -- Border characters of the floating window
				default_mappings = true,
				debug = false, -- Print debug information
				opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
				resizing_mappings = false, -- Binds arrow keys to resizing the floating window.
				post_open_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
				references = { -- Configure the telescope UI for slowing the references cycling window.
					telescope = require("telescope.themes").get_dropdown({ hide_preview = false }),
				},
				-- These two configs can also be passed down to the goto-preview definition and implementation calls for one off "peak" functionality.
				focus_on_open = true, -- Focus the floating window when opening it.
				dismiss_on_move = false, -- Dismiss the floating window when moving the cursor.
				force_close = true, -- passed into vim.api.nvim_win_close's second argument. See :h nvim_win_close
				bufhidden = "wipe", -- the bufhidden option to set on the floating window. See :h bufhidden
				stack_floating_preview_windows = true, -- Whether to nest floating windows
				preview_window_title = { enable = true, position = "left" }, -- Whether
			})
		end,
	},

	{
		"folke/trouble.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("trouble").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	},

	{
		"folke/todo-comments.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		lazy = false,
		config = function()
			require("todo-comments").setup({})
		end,
	},

	{
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({
				background_colour = "#000000",
				enabled = false,
			})
		end,
	},
	"ray-x/go.nvim",
	"ray-x/guihua.lua",
	{ "catppuccin/nvim", as = "catppuccin" },
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},

	{ -- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",

			-- Useful status updates for LSP
			"j-hui/fidget.nvim",
		},
	},

	{ -- Autocompletion
		"hrsh7th/nvim-cmp",
		dependencies = { "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip" },
	},

	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		build = function()
			pcall(require("nvim-treesitter.install").update({ with_sync = true }))
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
	},
	-- Git related plugins
	"tpope/vim-fugitive",
	"lewis6991/gitsigns.nvim",

	"nvim-lualine/lualine.nvim", -- Fancier statusline
	--{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
	"numToStr/Comment.nvim", -- "gc" to comment visual regions/lines
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically

	-- Fuzzy Finder (files, lsp, etc)
	{ "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
	"nvim-telescope/telescope-symbols.nvim",
	-- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = vim.fn.executable("make") == 1 },
	{
		"folke/twilight.nvim",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	{
		"simrat39/symbols-outline.nvim",
	},
	-- Barbecue
	{
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
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	{
		"phaazon/hop.nvim",
		branch = "v2", -- optional but strongly recommended
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
		end,
	},
	--Auto-save
	{ "Pocco81/auto-save.nvim" },
	{ "minamorl/nvim-clean-paste" },
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
	-- lazy.nvim
	{
		"tris203/precognition.nvim",
		--event = "VeryLazy",
		config = {
			-- startVisible = true,
			-- showBlankVirtLine = true,
			-- highlightColor = { link = "Comment" },
			-- hints = {
			--      Caret = { text = "^", prio = 2 },
			--      Dollar = { text = "$", prio = 1 },
			--      MatchingPair = { text = "%", prio = 5 },
			--      Zero = { text = "0", prio = 1 },
			--      w = { text = "w", prio = 10 },
			--      b = { text = "b", prio = 9 },
			--      e = { text = "e", prio = 8 },
			--      W = { text = "W", prio = 7 },
			--      B = { text = "B", prio = 6 },
			--      E = { text = "E", prio = 5 },
			-- },
			-- gutterHints = {
			--     G = { text = "G", prio = 10 },
			--     gg = { text = "gg", prio = 9 },
			--     PrevParagraph = { text = "{", prio = 8 },
			--     NextParagraph = { text = "}", prio = 8 },
			-- },
		},
	},
	{
		"stevearc/oil.nvim",
		opts = {},
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
})
