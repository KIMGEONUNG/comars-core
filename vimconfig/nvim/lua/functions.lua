-- FUNCTIONS ------------------------------------------------------------------

-- It is borrowed from https://www.notonlycode.org/neovim-lua-config/

function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
  map('n', shortcut, command)
end

function imap(shortcut, command)
  map('i', shortcut, command)
end

vim.cmd([[

function! DeleteBackward() abort

    return
    let num_cur = col('.') - 2
    " what are you trying to do.
    " insert dkdk <c-h>

    echom num_cur
    return
    while num_cur >= 0
        let num_cur = col('.') - 2
        let char_cur = getline('.')[num_cur]
        echo num_cur
        echo char_cur
        echo "hel"
        break
        if char_cur == ' ' || char_cur == '_' || char_cur == '.'
            break
        endif
        normal X
    endwhile

    " echo num_cur
    " echo char_cur 
    " echo "hell" 
    return
    let num_line = line('.')
    let num_col = col('.')
    let num_end = 1

    while num_col >= num_end 
        let num_col -= 1
        let c_cur = getline('.')[num_col]
        if c_cur == ' ' || c_cur == '_' || c_cur == '.'
            let num_end = num_col + 1
            break
        endif
    endwhile

    normal v
    call cursor(num_line, num_end)
    normal x

endfunction

function! ExecutePredef()
    write
    if filereadable('vim.run.sh')
         !bash vim.run.sh
    endif
endfunction

" File specific fast execution
function! ExecuteFile(arg)
    write

    " check shebang 
    let line = getline(1)
    if line[:1] == '#!'
        let cmd = line[2:]
        execute "!" . cmd  "%"
        return ''
    endif

    if !empty(matchstr(a:arg, '.py$'))
        !python % 
    elseif !empty(matchstr(a:arg, '.html$'))
        !google-chrome %
    elseif !empty(matchstr(a:arg, '.js$'))
        !google-chrome index.html 
    elseif !empty(matchstr(a:arg, '.css$'))
        !google-chrome index.html 
    elseif !empty(matchstr(a:arg, '.sh$'))
        !bash % 
    elseif !empty(matchstr(a:arg, '.cpp$')) || !empty(matchstr(a:arg, '.h$'))
        let target = 'doit.sh'
        if filereadable(target)
            !bash doit.sh
        else
            echo "No target file:" target
        endif

    elseif !empty(matchstr(a:arg, '.vim$'))
        so % 
    endif
endfunction

" LSP formatting
function! Format(arg)
    if !empty(matchstr(a:arg, '.json$'))
        :lua vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
    else
        :lua vim.lsp.buf.formatting()
    endif
endfunction

function! DeleteTo()
    " let char = nr2char(getchar()) " or
    let c = getcharstr()

    let col_current = col('.')
    let cnt = 0
    let touch = 0

    while col_current < col('$') - 1
      let col_current += 1
      let cnt += 1
      if getline('.')[col_current - 1] ==? c 
        let touch = 1
        break
      endif
    endwhile

    if touch == 0
      return ''
    endif
      
    normal v
    while cnt > 0
        let cnt -= 1
        normal l
    endwhile
    normal x
endfunction

function! DeleteChar()
    let c = getcharstr()
    let num_end = col('$')
    let num_col = col('.')
    let num_line = line('.')
    let targets = []

    echo num_end

    let i = 0
    while i < num_end - 1
        let c_cur = getline('.')[i]
        if c == c_cur
            let targets += [i]
        endif
        let i += 1
    endwhile

    call reverse(targets)

    for i in targets
        let idx = i + 1
        call cursor(num_line, idx)
        normal x

        " adjustment for final column number 
        if idx < num_col
            let num_col -= 1
        endif
    endfor
    call cursor(num_line, num_col)
endfunction

function! DeleteInnerArg()
    let num_line = line('.')
    let col_init = col('.')
    let col_num = col('.')
    let col_start = -1
    let col_end = -1
    let is_fist_arg = 0
    let is_last_arg = 0

    " Find start point 
    while 1  
        let col_num -= 1

        let char_cur = getline('.')[col_num - 1]

        if char_cur == ')' 
            return
        endif

        if char_cur == ','
            let col_start = col_num + 1
            break
        endif
        if char_cur == '(' 
            let is_fist_arg = 1
            let col_start = col_num + 1
            break
        endif

        if col_num <= 0 
            return
        endif
    endwhile

    " Find end point 
    while 1  
        let col_num += 1
        let char_cur = getline('.')[col_num - 1]

        if char_cur == ')' 
            let is_last_arg = 1
            let col_end = col_num
            break
        endif
        if char_cur == ','
            let col_end = col_num
            break
        endif

        if col('$') < col_num 
            return
        endif
    endwhile

    " rearrange for first and last argument
    if is_fist_arg && is_last_arg
        " let col_start += 1
        let col_end -= 1
    else
        if is_fist_arg
            let col_end += 1
        endif
        if is_last_arg
            let col_start -= 1
            let col_end -= 1
        endif
    endif

    " Delete
    call cursor(num_line, col_start)
    normal v
    call cursor(num_line, col_end)
    normal x
endfunction
 
]])

