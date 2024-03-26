-- Package management.
require("paq")({
	-- Package manager.
	"savq/paq-nvim",

	-- Snippet manager.
	"rafamadriz/friendly-snippets",
	"L3MON4D3/LuaSnip",

	-- Completion related packages.
	"davidsierradz/cmp-conventionalcommits",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-path",
	"petertriho/cmp-git",
	"saadparwaiz1/cmp_luasnip",
	"hrsh7th/nvim-cmp",

	-- LSP.
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",
	"nvimdev/lspsaga.nvim",

	-- nvim-tree.
	"kyazdani42/nvim-tree.lua",
	"kyazdani42/nvim-web-devicons",

	-- Code formatting.
	"nvim-treesitter/nvim-treesitter",
	"sbdchd/neoformat",

	-- Utils.
	"nvim-lua/plenary.nvim",
	"numToStr/Comment.nvim",
	"nvim-telescope/telescope.nvim",
	"GCBallesteros/jupytext.nvim",
	"Vigemus/iron.nvim",
	"kana/vim-textobj-user",
	"GCBallesteros/vim-textobj-hydrogen",
	"lewis6991/gitsigns.nvim",
	"folke/which-key.nvim",

	-- Fancy UI stuff.
	"onsails/lspkind-nvim",

	-- Debug Adapter
	"mfussenegger/nvim-dap",
	"rcarriga/nvim-dap-ui",
})
