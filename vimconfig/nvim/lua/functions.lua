-- FUNCTIONS ------------------------------------------------------------------

function Quit()
  -- CHECK THE NUMBER OF BUFFERS
  local num_buf = vim.fn.bufnr('$')
  local cnt = 0
  for i = 1, num_buf do
    if vim.fn.buflisted(i) == 1 then
      cnt = cnt + 1
    end
  end

  -- SELECT OPERATION
  if cnt <= 1 then
    vim.api.nvim_command('quit')
  else
    vim.api.nvim_command('bwipe')
  end
end

vim.cmd([[

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
    elseif !empty(matchstr(a:arg, '.lua$'))
        !lua %
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
