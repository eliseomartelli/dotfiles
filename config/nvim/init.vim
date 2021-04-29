" Basic Settings {{{
set nocompatible
filetype indent plugin on
set encoding=utf-8

" Add the ability to hide a buffer.
set hidden

" Configure tab and indent behavior.
set tabstop=4
set shiftwidth=4
set noexpandtab
set autoindent

" Configure spell checking.
set spelllang=en_us,it
set spell

" Configure command line.
set wildmenu
set wildmode=list:longest,full
set showcmd
set cmdheight=1

" Add search highlight.
set hlsearch
set incsearch

" Case insensitive, only if lowercase.
set ignorecase
set smartcase

" Allow backspacing over auto indent, line breaks and start of insert.
set backspace=indent,eol,start

" Don't change column when changing buffer.
set nostartofline

" Some visual settings.
syntax on
set termguicolors
set ruler
set confirm
set mouse=a
set number
set relativenumber
set conceallevel=1
set foldmethod=marker
set colorcolumn=80
set cursorline
set shortmess+=c
set nomodeline
set list

" Set bases for increments.
set nrformats+=alpha

" Quickly time out on key codes, but never time out on mappings.
set notimeout ttimeout ttimeoutlen=200

" Preserve indentation.
set breakindent
set linebreak

" Write swap every 1 second.
set updatetime=1000

" Manage undo.
set undofile

" Set path for search.
set path+=**

let g:vimspector_enable_mappings = 'HUMAN'
" }}}

runtime plugins.vim
runtime coc.vim
runtime remaps.vim
runtime colorscheme.vim
runtime statusline.vim
