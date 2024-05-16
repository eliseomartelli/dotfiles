-- Base configurations.
local opt = vim.opt

-- Ability to hide a buffer.
opt.hidden = true

-- Tab and indent.
opt.tabstop = 4
opt.shiftwidth = 4
opt.autoindent = true
opt.breakindent = true
opt.linebreak = true

-- Search.
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.path = opt.path + "**"

-- Backspace.
opt.backspace = "indent,eol,start"

-- Visuals.
opt.termguicolors = false
opt.ruler = true
opt.confirm = true
opt.mouse = "a"
opt.number = true
opt.relativenumber = true
opt.foldenable = false
opt.foldmethod = "marker"
opt.colorcolumn = "80"
opt.shortmess = opt.shortmess + "c"
opt.list = true
opt.splitbelow = true
opt.splitright = true
opt.completeopt = "menuone,noselect"
opt.signcolumn = "yes"

-- Increments.
opt.nrformats = opt.nrformats + "alpha"

-- Undo.
opt.undofile = true

-- Colorscheme.
vim.cmd([[colorscheme vim]])
