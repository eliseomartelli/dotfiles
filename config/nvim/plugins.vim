call plug#begin('~/.config/nvim/plugged')
	Plug 'dsznajder/vscode-es7-javascript-react-snippets', { 'do': 'yarn install --frozen-lockfile && yarn compile' }
	Plug 'HerringtonDarkholme/yats.vim', {'as': 'yats'}
	Plug 'airblade/vim-gitgutter'
	Plug 'jremmen/vim-ripgrep'
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/goyo.vim', {'as': 'goyo'}
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
	\ 'coc-java',
	\ 'coc-json',
	\ 'coc-pairs',
	\ 'coc-prettier',
	\ 'coc-pyright',
	\ 'coc-snippets',
	\ 'coc-tabnine',
	\ 'coc-tailwindcss',
	\ 'coc-tsserver',
	\ ]
