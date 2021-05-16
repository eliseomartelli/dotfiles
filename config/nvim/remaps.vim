" Move and indent selected lines
vnoremap K :move '<-2<CR>gv=gv
vnoremap J :move '>+1<CR>gv=gv

" Save file as sudo on files that require root permission
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Change working directory
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" Open file explorer
nnoremap <leader>e :CocCommand explorer<CR>

" Make arrow keys do something useful, resize the view ports accordingly
nnoremap <Left> :vertical resize +5<CR>
nnoremap <Right> :vertical resize -5<CR>
nnoremap <Up> :resize +5<CR>
nnoremap <Down> :resize -5<CR>

" Map file search.
map <C-t> :FZF <CR>
map <Leader>t :Rg <CR>

" Clear highlighting on escape in normal mode
nnoremap <esc> :noh<return>

" Allow escape to be remapped
nnoremap <esc>^[ <esc>^[

" Open workspace terminal.
nnoremap <leader>s :below 10sp term://$SHELL<CR>i

" Toggle goyo
map <Leader>g :Goyo <CR>
