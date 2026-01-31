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

require("lazy").setup({
	"tpope/vim-sleuth",
	-- Git signs
	{
	  'lewis6991/gitsigns.nvim',
	  opts = {
		numhl = true,
		sign_priority = 15, -- higher than diagnostic,todo signs. lower than dapui breakpoint sign
	  },
	},
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {}
	},
	-- Theme
	-- { "rmehri01/onenord.nvim" },
	-- { "AlexvZyl/nordic.nvim" },
	-- { "EdenEast/nightfox.nvim" },
	-- { "navarasu/onedark.nvim" },
	{ "sainnhe/everforest" }, 
	{ "nvim-lualine/lualine.nvim",       dependencies = { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font } },
	{ "stevearc/oil.nvim",               dependencies = { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font } },
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	{ "mbbill/undotree" },
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
	},
	-- Indent guides
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
	},
	-- Auto format
	{
		"stevearc/conform.nvim",
		lazy = false,
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
	},
	{
		'saghen/blink.cmp',
		event = { 'LspAttach' },
		version = '1.*',
	},

	{
		'kristijanhusak/vim-dadbod-ui',
		dependencies = {
			{ 'tpope/vim-dadbod', lazy = true },
			{ 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
			cmd = {
			  'DBUI',
			  'DBUIToggle',
			  'DBUIAddConnection',
			  'DBUIFindBuffer',
			},
			init = function()
			  vim.g.db_ui_use_nerd_fonts = 1
			end,
		},
	},
	-- { 'github/copilot.vim' },
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
	},
	{
	  "j-hui/fidget.nvim",
	  opts = {},
	},
	{
		'mrcjkb/rustaceanvim',
		version = '^6', -- Recommended
		lazy = false, -- This plugin is already lazy
	},
	{
		"saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		opts = {}
	},
	-- better markdown rendering
	{ "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown" } },
	-- Paste img into markdown
	"dfendr/clipboard-image.nvim",
})
