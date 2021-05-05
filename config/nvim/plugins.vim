call plug#begin('~/.config/nvim/plugged')
	Plug 'crusoexia/vim-monokai'
	Plug 'airblade/vim-gitgutter'
	Plug 'rhysd/git-messenger.vim'
	Plug 'jremmen/vim-ripgrep'
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'tpope/vim-fugitive'
	Plug 'tpope/vim-rhubarb'
	Plug 'tpope/vim-commentary'
	Plug 'puremourning/vimspector'
call plug#end()


let g:coc_global_extensions = [
	\ 'coc-clangd',
	\ 'coc-deno',
	\ 'coc-eslint',
	\ 'coc-explorer',
	\ 'coc-highlight',
	\ 'coc-html',
	\ 'coc-json',
	\ 'coc-pairs',
	\ 'coc-prettier',
	\ 'coc-pyright',
	\ 'coc-tabnine',
	\ 'coc-tsserver',
	\ ]
