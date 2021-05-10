call plug#begin('~/.config/nvim/plugged')
	Plug 'HerringtonDarkholme/yats.vim', {'as': 'yats'}
	Plug 'airblade/vim-gitgutter'
	Plug 'jremmen/vim-ripgrep'
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'mhartington/oceanic-next'
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'puremourning/vimspector'
	Plug 'rhysd/git-messenger.vim'
	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-fugitive'
	Plug 'tpope/vim-rhubarb'
call plug#end()


let g:coc_global_extensions = [
	\ 'coc-clangd',
	\ 'coc-deno',
	\ 'coc-emmet',
	\ 'coc-eslint',
	\ 'coc-explorer',
	\ 'coc-highlight',
	\ 'coc-html',
	\ 'coc-json',
	\ 'coc-pairs',
	\ 'coc-prettier',
	\ 'coc-pyright',
	\ 'coc-tabnine',
	\ 'coc-tailwindcss',
	\ 'coc-tsserver',
	\ ]
