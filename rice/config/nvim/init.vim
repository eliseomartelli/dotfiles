" Vim Plug Plugins

call plug#begin('~/.vim/plugged')
    Plug 'scrooloose/nerdtree'
    " Plug 'Valloric/YouCompleteMe'
call plug#end()

nmap <Bslash> :NERDTreeToggle<CR>

imap <S-Tab> <C-P>


set number          " Show Line Numbers
set relativenumber  " Set Relative Line Numbers
set tabstop=4       " Show Tabs as 4 spaces
set shiftwidth=4    " Tabs treated as 4 spaces
set expandtab       " Convert tab into spaces

set wrap!           " Don't wrap long lines

set autoindent      " Use indent from prev line
set ignorecase      " Search case insensitive

set ruler           " Show line and col in status
set mouse=a         " Add mouse support

nnoremap <Up>       :resize +2<CR>              " Resize +
nnoremap <Down>     :resize -2<CR>              " Resize -
nnoremap <Left>     :vertical resize +2<CR>     " Resize vertical+
nnoremap <Right>    :vertical resize -2<CR>     " Resize vertical-
