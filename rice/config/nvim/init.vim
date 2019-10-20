set number 

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'vim-syntastic/syntastic'
Plug 'valloric/youcompleteme'

call plug#end()

nmap <Bslash> :NERDTreeToggle<CR>

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
