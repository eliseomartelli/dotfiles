require "paq" {
	-- paq-nvim.
	"savq/paq-nvim";

	-- nvim-treesitter.
	{'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'};

	-- nvim-lspconfig.
	"neovim/nvim-lspconfig";

	-- vim-vsnip.
	"hrsh7th/vim-vsnip";
	"hrsh7th/vim-vsnip-integ"; -- Add support for plugins to vim-vsnip.
	"rafamadriz/friendly-snippets";

	-- nvim-cmp.
	"hrsh7th/nvim-cmp";
	"hrsh7th/cmp-nvim-lsp"; -- Add support for builtin lsp to nvim-cmp.
	"hrsh7th/cmp-vsnip"; -- Add suport for vsnip to nvim-cmp.
	"hrsh7th/cmp-buffer"; -- Add support for buffer to nvim-cmp.
	"hrsh7th/cmp-path"; -- Add support for path to nvim-cmp.

	-- vim-fugitive.
	"tpope/vim-fugitive";

	-- nvim-tree.
	"kyazdani42/nvim-tree.lua";
	"kyazdani42/nvim-web-devicons";

	-- oceanic-next.
	"mhartington/oceanic-next";

	-- telescope.
	"nvim-lua/plenary.nvim";
	"nvim-telescope/telescope.nvim";

	-- cheat.sh.
	"dbeniamine/cheat.sh-vim";

	--lualine.
	'nvim-lualine/lualine.nvim';
}

