require "paq" {
  "savq/paq-nvim";
  "onsails/lspkind-nvim"; -- vscode-like pictograms

  "hrsh7th/cmp-buffer"; -- nvim-cmp source for buffer words
  "hrsh7th/cmp-nvim-lsp"; -- nvim-cmp source for neovim's built-in LSP
  "hrsh7th/cmp-path"; -- Add support for path to nvim-cmp.
  "hrsh7th/nvim-cmp"; -- Completion

  "neovim/nvim-lspconfig"; -- LSP
  "williamboman/nvim-lsp-installer"; -- LSP installer

  "jose-elias-alvarez/null-ls.nvim"; -- Neovim as a lsp
  "MunifTanjim/prettier.nvim"; -- prettier
  "L3MON4D3/LuaSnip"; -- snippets
  "glepnir/lspsaga.nvim"; -- LSP UIs

  -- nvim-tree.
  "kyazdani42/nvim-tree.lua";
  "kyazdani42/nvim-web-devicons";

  { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' };

  "sbdchd/neoformat"; -- neoformat

  "chriskempson/vim-tomorrow-theme"; --theme
}
