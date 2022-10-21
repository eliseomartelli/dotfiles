require "paq" {
  "savq/paq-nvim";
  "onsails/lspkind-nvim"; -- vscode-like pictograms

  "hrsh7th/cmp-buffer"; -- nvim-cmp source for buffer words
  "hrsh7th/cmp-nvim-lsp"; -- nvim-cmp source for neovim's built-in LSP
  "hrsh7th/cmp-path"; -- Add support for path to nvim-cmp.
  "hrsh7th/nvim-cmp"; -- Completion

  "neovim/nvim-lspconfig"; -- LSP
  "williamboman/mason.nvim"; -- Mason
  "williamboman/mason-lspconfig.nvim"; -- Mason LSP Config

  "jose-elias-alvarez/null-ls.nvim"; -- Neovim as a lsp
  "MunifTanjim/prettier.nvim"; -- prettier
  "L3MON4D3/LuaSnip"; -- snippets
  "glepnir/lspsaga.nvim"; -- LSP UIs
  "rafamadriz/friendly-snippets"; -- frielndlysnippets

  -- nvim-tree.
  "kyazdani42/nvim-tree.lua";
  "kyazdani42/nvim-web-devicons";

  { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' };

  "sbdchd/neoformat"; -- neoformat

  "yazeed1s/minimal.nvim"; -- theme

  "nvim-lua/plenary.nvim";
  "nvim-telescope/telescope.nvim";
}
