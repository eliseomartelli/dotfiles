require("config.paq")
require("config.cmp")
require("config.colorscheme")
require("config.lsp")
require("config.treesitter")
require("remaps")

require "paq" {
	"savq/paq-nvim";
	"neovim/nvim-lspconfig";
	{'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'};
	"kyazdani42/nvim-web-devicons";
	"kyazdani42/nvim-tree.lua";
	"rafamadriz/friendly-snippets";
	"hrsh7th/cmp-vsnip";
	"hrsh7th/vim-vsnip-integ";
	"hrsh7th/cmp-nvim-lsp";
	"hrsh7th/nvim-cmp";
    "hrsh7th/vim-vsnip";
    "hrsh7th/cmp-buffer";
	"mhartington/oceanic-next";
}

-- filetype indent plugin on
vim.opt.encoding = 'utf-8'

-- Add the ability to hide a buffer.
vim.opt.hidden = true

-- Configure tab and indent behavior.
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
-- vim.opt.noexpandtab = true
vim.opt.autoindent = true

-- Configure command line.
vim.opt.wildmenu = true
vim.opt.wildmode= 'list:longest,full'
vim.opt.showcmd = true
vim.opt.cmdheight = 1

-- Add search highlight.
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Case insensitive, only if lowercase.
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Allow backspacing over auto indent, line breaks and start of insert.
vim.opt.backspace= 'indent,eol,start'

-- Don't change column when changing buffer.
-- vim.opt.nostartofline = true

-- Some visual settings.
-- vim.opt.syntax = true
vim.opt.termguicolors = true
vim.opt.ruler = true
vim.opt.confirm = true
vim.opt.mouse= 'a'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.foldmethod= 'marker'
vim.opt.colorcolumn= '80'
vim.opt.cursorline = true
vim.opt.shortmess = vim.opt.shortmess + 'c'
-- vim.opt.nomodeline = true
vim.opt.list = true

-- Set bases for increments.
vim.opt.nrformats = vim.opt.nrformats + 'alpha'

-- Preserve indentation.
vim.opt.breakindent = true
vim.opt.linebreak = true

-- Write swap every 1 second.
-- set updatetime=1000

-- Manage undo.
vim.opt.undofile = true

-- Set path for search.
vim.opt.path = vim.opt.path + '**'

-- Split below and right by default.
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Copleteopt
vim.opt.completeopt = 'menuone,noselect'
