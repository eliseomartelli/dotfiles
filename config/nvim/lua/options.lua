local opt = vim.opt

-- Add the ability to hide a buffer.
opt.hidden = true

-- Configure tab and indent behavior.
opt.tabstop = 4
opt.shiftwidth = 4
opt.autoindent = true

-- Configure command line.
opt.wildmenu = true
opt.wildmode= 'list:longest,full'
opt.showcmd = true
opt.cmdheight = 1

-- Add search highlight.
opt.hlsearch = true
opt.incsearch = true

-- Case insensitive, only if lowercase.
opt.ignorecase = true
opt.smartcase = true

-- Allow backspacing over auto indent, line breaks and start of insert.
opt.backspace= 'indent,eol,start'

-- Some visual settings.
opt.termguicolors = true
opt.ruler = true
opt.confirm = true
opt.mouse= 'a'
opt.number = true
opt.relativenumber = true
opt.foldmethod= 'marker'
opt.colorcolumn= '80'
opt.foldenable = false
opt.cursorline = true
opt.shortmess = opt.shortmess + 'c'
opt.list = true

-- Set bases for increments.
opt.nrformats = opt.nrformats + 'alpha'

-- Preserve indentation.
opt.breakindent = true
opt.linebreak = true

-- Manage undo.
opt.undofile = true

-- Set path for search.
opt.path = opt.path + '**'

-- Split below and right by default.
opt.splitbelow = true
opt.splitright = true

-- Copleteopt
opt.completeopt = 'menuone,noselect'

require'nvim-tree'.setup()
require'formatter'.setup()
