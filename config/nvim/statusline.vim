function! StatusLineGit()
	let l:branchname = FugitiveHead()
	return strlen(l:branchname) > 0 ? '   '.l:branchname.' ' : ''
endfunction

set laststatus=2
set statusline+=%#PmenuSel#
set statusline+=%{StatusLineGit()} 
set statusline+=%#LineNr#
set statusline+=\ %{expand('%:~:.')}
set statusline+=%=
set statusline+=%#DiffChange#
set statusline+=\ %{coc#status()}%{get(b:,'coc_current_function','')}\ 
set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c\ 
