-- Package management.
require "paq" {
  "savq/paq-nvim"; -- paq

  -- Completion related packages.
  "davidsierradz/cmp-conventionalcommits"; -- conventionalcommits
  "hrsh7th/cmp-buffer"; -- nvim-cmp source for buffer words
  "hrsh7th/cmp-cmdline"; -- Add support for cmdline to nvim-cmp.
  "hrsh7th/cmp-nvim-lsp"; -- nvim-cmp source for neovim's built-in LSP
  "hrsh7th/cmp-path"; -- Add support for path to nvim-cmp.
  "hrsh7th/nvim-cmp"; -- Completion
  "petertriho/cmp-git"; -- Cmp git.
  "saadparwaiz1/cmp_luasnip"; -- LuaSnip cmp.

  -- LSP install and configuration.
  "williamboman/mason.nvim"; -- Mason
  "williamboman/mason-lspconfig.nvim"; -- Mason LSP Config
  "neovim/nvim-lspconfig"; -- LSP

  -- LSP UI.
  "nvimdev/lspsaga.nvim"; -- LSP UI

  -- Snippet manager.
  "rafamadriz/friendly-snippets"; -- frielndlysnippets
  "L3MON4D3/LuaSnip"; -- snippets

  -- nvim-tree.
  "kyazdani42/nvim-tree.lua";
  "kyazdani42/nvim-web-devicons";

  -- Treesitter.
  'nvim-treesitter/nvim-treesitter';

  -- Code formatter.
  "sbdchd/neoformat"; -- neoformat

  -- Utils.
  "nvim-lua/plenary.nvim"; -- plenary

  -- Telescope.
  "nvim-telescope/telescope.nvim";

  -- Misc.
  "onsails/lspkind-nvim"; -- vscode-like pictograms
  -- "yazeed1s/minimal.nvim"; -- theme
  "lewis6991/impatient.nvim";
}
