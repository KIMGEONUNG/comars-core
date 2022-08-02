
vim.cmd([[

" DEBUG ONLY==================================================================
" My intention of this implementation is for esay vim debug environment.
" The desired debugging stpe is as follows.
" 1. If the current filename has extention *.debugvim, then debugging only 
"   keymapping would be activated. One for debugging function, the other for
"   script update.
" 2. Ctr+a keymapping is for executing debugging function.
" 3. Ctr+s keymapping would update modified script. The target script must be
" .nvimrc file with current working directory.
"
function! MyDebug() abort
    echo 'default debug function'
endfunction

if !empty(matchstr(expand('%:t'), '.debugvim$'))
    nnoremap <c-a> :call MyDebug()<cr>
    nnoremap <c-s> :so .nvimrc<cr>
endif
" DEBUG ONLY===============================================================END

]])
