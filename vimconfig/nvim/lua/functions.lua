local function file_exists(file)
  local f = io.open(file, "r")
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end

vim.api.nvim_create_user_command('Godoc', function(args)
  local path_buf = vim.api.nvim_buf_get_name(0)
  local cwd = vim.fn.getcwd()
  local relative = string.sub(path_buf, #cwd + 2, #path_buf)
  local filename = path_buf:match("^.+/(.+)$")
  local id = string.match(filename, "^([A-Z]%d%d%d)%-")

  if string.match(filename, "^[A-Z]%d%d%d%-.*%.py$") ~= nil then
    local path_new = cwd .. '/docs/' .. id .. ".tex"
    print('pass: ' .. id .. ", open: " .. path_new)
    vim.cmd("edit " .. path_new)

    if not file_exists(path_new) then
      local buf = vim.api.nvim_get_current_buf()
      vim.api.nvim_buf_set_lines(buf, 0, -1, false,
        { "\\section{" .. id .. "} % (fold)", "\\label{sec:" .. id .. "}", "", "% section  (end)" })

      -- Set the cursor position to the third line (indexing starts from 0)
      vim.api.nvim_win_set_cursor(0, { 3, 0 })
    end


  else
    print('Current buffer file does not have proper name for document mapping')
  end
end, {})
-------------------------------------------------------------------------------

function OpenNullBuffer()
  vim.api.nvim_command("vs /dev/null")
end

function NumListedBuf()
  local num_buf = vim.fn.bufnr('$')
  local cnt = 0
  for i = 1, num_buf do
    if vim.fn.buflisted(i) == 1 then
      cnt = cnt + 1
    end
  end
  return cnt
end

function Quit()
  -- CHECK THE NUMBER OF LISTED BUFFERS
  local cnt = NumListedBuf()
  print("NumListedBuffer", cnt)

  -- SELECT OPERATION
  -- if cnt <= 1 or vim.bo.filetype == "tex" then
  if cnt <= 1 then
    vim.api.nvim_command('quit')
  else
    vim.api.nvim_command('bwipe')
  end
end

function QuitF()
  -- CHECK THE NUMBER OF LISTED BUFFERS
  local cnt = NumListedBuf()

  -- SELECT OPERATION
  if cnt <= 1 then
    vim.api.nvim_command('quit!')
  else
    vim.api.nvim_command('bwipe!')
  end
end

function InsertTextWithBrace()
  local function insert_text_at(line, col, text)
    -- Get the current line content
    local current_line = vim.api.nvim_buf_get_lines(0, line - 1, line, false)[1]
    -- Insert the new text at the specified column
    local new_line = current_line:sub(1, col) .. text .. current_line:sub(col + 1)
    -- Set the new line
    vim.api.nvim_buf_set_lines(0, line - 1, line, false, { new_line })
  end

  -- FIND VISUAL POSITION
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")

  local start_line = start_pos[2]
  local start_col = start_pos[3]
  local end_line = end_pos[2]
  local end_col = end_pos[3]
  -- print("Visual selection starts at Line " .. start_line .. ", Column " .. start_col)
  -- print("Visual selection ends at Line " .. end_line .. ", Column " .. end_col)

  -- SPECIFIY
  local prefix = vim.fn.input("Prefix: ")
  if prefix == '' then
    print('empty exit')
    return
  end

  -- INSERT BRACKET AND CONTENT
  local last = prefix:sub(-1)
  local bracket_close = nil
  if last == "(" then
    bracket_close = ")"
  elseif last == "{" then
    bracket_close = "}"
  elseif last == "[" then
    bracket_close = "]"
  end

  if bracket_close == nil then
    print('bracket_close is nil')
  else
    prefix = prefix:sub(1, -2)
    insert_text_at(start_line, start_col - 1, last)
    insert_text_at(end_line, end_col + 1, bracket_close)
    insert_text_at(start_line, start_col - 1, prefix)
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

vim.api.nvim_create_user_command('Restore',
  function(args)
    -- Run the shell command and capture its output
    local handle = io.popen("who | head -n1 | awk -F ' ' '{ print $2 }'")
    local result = handle:read("*a")
    handle:close()
    -- Remove any trailing newline characters
    result = result:gsub("\n", "")
    -- Print the result
    print("Display number: " .. result)
    vim.fn.setenv("DISPLAY", result)
  end, {})
