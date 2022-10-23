-- Package management.
require "paq" {
  "savq/paq-nvim"; -- paq

  -- Completion related packages.
  "hrsh7th/cmp-buffer"; -- nvim-cmp source for buffer words
  "hrsh7th/cmp-nvim-lsp"; -- nvim-cmp source for neovim's built-in LSP
  "hrsh7th/cmp-path"; -- Add support for path to nvim-cmp.
  "hrsh7th/cmp-cmdline"; -- Add support for cmdline to nvim-cmp.
  "hrsh7th/nvim-cmp"; -- Completion
  "petertriho/cmp-git"; -- Cmp git.
  "davidsierradz/cmp-conventionalcommits"; -- conventionalcommits
  "saadparwaiz1/cmp_luasnip"; -- LuaSnip cmp.

  -- LSP install and configuration.
  "williamboman/mason.nvim"; -- Mason
  "williamboman/mason-lspconfig.nvim"; -- Mason LSP Config
  "neovim/nvim-lspconfig"; -- LSP

  -- LSP UI.
  "glepnir/lspsaga.nvim"; -- LSP UI

  -- Snippet manager.
  "rafamadriz/friendly-snippets"; -- frielndlysnippets
  "L3MON4D3/LuaSnip"; -- snippets

  -- nvim-tree.
  "kyazdani42/nvim-tree.lua";
  "kyazdani42/nvim-web-devicons";

  -- Treesitter.
  { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' };

  -- Code formatter.
  "sbdchd/neoformat"; -- neoformat

  -- Utils.
  "nvim-lua/plenary.nvim"; -- plenary

  -- Misc.
  "onsails/lspkind-nvim"; -- vscode-like pictograms
  "yazeed1s/minimal.nvim"; -- theme
  "nvim-telescope/telescope.nvim"; -- telescope
}
