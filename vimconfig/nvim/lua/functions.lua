
function OpenNullBuffer()
  vim.api.nvim_command("vs /dev/null")
end

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
