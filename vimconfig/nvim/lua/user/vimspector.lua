-- SELECT CONFIG
function SelectVimspectorConfig()
    local dir_config = "vimspectorconfigs"
  


    local function get_file_list()
        local handle = io.popen('ls ' ..  dir_config )
        local result = handle:read('*a')
        handle:close()
        return vim.split(result, '\n')
    end

    -- Function to display the contents of a file
    function link_config()
        local file = vim.api.nvim_get_current_line()
        local cmd = 'ln -sf ' .. dir_config .. '/' .. file .. ' .vimspector.json'
        local a = os.execute(cmd)
        if a == 0 then
          print("Command succeeded: " .. cmd)
        end
    end


    -- Calculate window size
    local width = vim.o.columns
    local height = vim.o.lines
    local ratio = 0.8
    local win_height = math.ceil(height * ratio - 4)
    local win_width = math.ceil(width * ratio / 2) 

    -- Calculate window position
    local row = math.ceil((height - win_height) / 2 - 1)
    local col = math.ceil((width - win_width * 2) / 2)

    -- Set window options
    local opts = {
        relative = 'editor',
        row = row,
        col = col,
        width = win_width,
        height = win_height,
        style = 'minimal',
        border = 'rounded',
        -- title = 'Config list',
        -- title_pos = 'center',
    }

    -- Create window and buffer
    local buf1 = vim.api.nvim_create_buf(false, true)
    local win1 = vim.api.nvim_open_win(buf1, true, opts)

    --  -- Adjust position for second window
    -- opts.row = opts.row + win_height / 4
    opts.col = opts.col + win_width + 3
    --
    -- -- Create window and buffer for file contents
    local buf2 = vim.api.nvim_create_buf(false, true)
    local win2 = vim.api.nvim_open_win(buf2, true, opts)


    -- Fill buffer with file list
    vim.api.nvim_buf_set_lines(buf1, 0, -1, false, get_file_list())

    -- Fill buffer with file list
    vim.api.nvim_buf_set_option(buf1, 'modifiable', false)
    vim.api.nvim_buf_set_option(buf2, 'modifiable', false)

    vim.api.nvim_set_current_win(win1)

    function on_cursor_move()
        vim.api.nvim_buf_set_option(buf2, 'modifiable', true)
        local file = vim.api.nvim_get_current_line()
        local path = dir_config .. '/' .. file
        local handle = io.open(path, 'r')
        local contents = handle:read('*a')
        handle:close()
        vim.api.nvim_buf_set_lines(buf2, 0, -1, false, vim.split(contents, '\n'))
        vim.api.nvim_buf_set_option(buf2, 'modifiable', false)
    end

    function close_all()
      vim.api.nvim_win_close(win2, true)
      vim.api.nvim_win_close(win1, true)
    end

    vim.api.nvim_create_autocmd("CursorMoved", {
      command = "lua on_cursor_move()",
      buffer = buf1,
    })

    vim.cmd("lua on_cursor_move()")

    -- Close window when any key is pressed
    vim.api.nvim_buf_set_keymap(buf1, 'n', '<CR>', '<cmd>lua link_config()<CR>', {})
    vim.api.nvim_buf_set_keymap(buf1, 'n', '<Esc>', '<cmd>lua close_all()<CR>', {})
    vim.api.nvim_buf_set_keymap(buf1, 'n', 'q', '<cmd>lua close_all()<CR>', {})

    vim.api.nvim_buf_set_keymap(buf2, 'n', '<CR>', '<cmd>lua link_config()<CR>', {})
    vim.api.nvim_buf_set_keymap(buf2, 'n', '<Esc>', '<cmd>lua close_all()<CR>', {})
    vim.api.nvim_buf_set_keymap(buf2, 'n', 'q', '<cmd>lua close_all()<CR>', {})
end

vim.api.nvim_create_user_command("SelectVimspectorConfig", 'lua SelectVimspectorConfig()', {}) 

-- FOR FAST SNIPPET EDITING
function StartDebug()
  vim.api.nvim_command(":w")
  vim.api.nvim_command("call vimspector#Launch()")
end

function ExitDebug()
  -- IF DEBUGGING DID NOT START, FINISH
  if vim.g.vimspector_session_windows == nil then
    return
  end

  -- DELETE TERMINAL
  local win_id = vim.g.vimspector_session_windows.terminal
  local buf_id = vim.fn.winbufnr(win_id)
  vim.api.nvim_buf_delete(buf_id, { force = true })

  -- QUIT DEBUG
  vim.api.nvim_command("call vimspector#Reset()")
end

local mapped = {}
local remaps = {
  { "n", "dl", "<Plug>VimspectorStepInto<CR>", },
  { "n", "dk", "<Plug>VimspectorStepOut<CR>", },
  { "n", "dj", "<Plug>VimspectorStepOver<CR>", },
  { "n", "db", "<Plug>VimspectorToggleBreakpoint<CR>", },

  { "n", "di", "<Plug>VimspectorBalloonEval<CR>", },
  { "x", "di", "<Plug>VimspectorBalloonEval<CR>", },
}

function OnJumpToFrame()
  local bufnr = vim.api.nvim_get_current_buf()

  if mapped[bufnr] then
    return
  end
  local status, err = pcall(function()
    local option = { noremap = true, silent = true }
    for _, v in ipairs(remaps) do
      vim.api.nvim_buf_set_keymap(bufnr, v[1], v[2], v[3], option)
    end
  end)
  -- print(err)
  mapped[bufnr] = { modifiable = vim.api.nvim_buf_get_option(bufnr, 'modifiable') }
  vim.api.nvim_buf_set_option(bufnr, 'modifiable', false)
end

function OnDebugEnd()
  local original_buf = vim.api.nvim_get_current_buf()
  local hidden = vim.o.hidden

  vim.o.hidden = true

  for bufnr in pairs(mapped) do
    pcall(function()
      vim.api.nvim_set_current_buf(tonumber(bufnr))
      vim.api.nvim_buf_del_keymap(bufnr, 'n', 'dj')
      vim.api.nvim_buf_set_option(bufnr, 'modifiable', mapped[bufnr].modifiable)
      for _, v in ipairs(remaps) do
        vim.api.nvim_buf_del_keymap(bufnr, v[1], v[2])
      end
    end)
  end
  vim.api.nvim_set_current_buf(original_buf)
  vim.o.hidden = hidden
  mapped = {}
end

vim.g.vimspector_enable_mappings = 'HUMAN'
vim.api.nvim_set_keymap('n', '<leader>dd', '<Cmd>lua StartDebug()<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>de', '<Cmd>lua ExitDebug()<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>d<space>', ':call vimspector#Continue()<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>dp', ':call vimspector#Pause()<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>drc', '<Plug>VimspectorRunToCursor', {})
vim.api.nvim_set_keymap('n', '<leader>dbp', '<Plug>VimspectorToggleBreakpoint', {})
vim.api.nvim_set_keymap('n', '<leader>dbc', '<Plug>VimspectorToggleConditionalBreakpoint', {})
-- nnoremap <leader>dtcb :call vimspector#CleanLineBreakpoint()<CR>

local opt = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>dt", ":lua vim.fn.win_gotoid(vim.g.vimspector_session_windows.terminal)<CR>", opt)
vim.keymap.set("n", "<leader>dc", ":lua vim.fn.win_gotoid(vim.g.vimspector_session_windows.code)<CR>", opt)
vim.keymap.set("n", "<leader>dv", ":lua vim.fn.win_gotoid(vim.g.vimspector_session_windows.variables)<CR>", opt)
vim.keymap.set("n", "<leader>dw", ":lua vim.fn.win_gotoid(vim.g.vimspector_session_windows.watches)<CR>", opt)
vim.keymap.set("n", "<leader>ds", ":lua vim.fn.win_gotoid(vim.g.vimspector_session_windows.stack_trace)<CR>", opt)
vim.keymap.set("n", "<leader>do", ":lua vim.fn.win_gotoid(vim.g.vimspector_session_windows.output)<CR>", opt)

-- FINALLY, ENROLL AUTOGROUP
-- Note that the dual vimscript of the lua's one.
-- "User" is an event and "VimspectorJumpedToFrame" and "VimspectorDebugEnded" are the pattern
local group = vim.api.nvim_create_augroup("VimspectorCustomBehavior", { clear = true })
vim.api.nvim_create_autocmd("User", {
  pattern = "VimspectorJumpedToFrame",
  command = "lua OnJumpToFrame()",
  group = group,
})
vim.api.nvim_create_autocmd("User", {
  pattern = "VimspectorDebugEnded",
  command = "lua OnDebugEnd()",
  group = group
})

-- augroup VimspectorCustomBehavior
--   au!
--   autocmd User VimspectorJumpedToFrame lua OnJumpToFrame()
--   autocmd User VimspectorDebugEnded lua OnDebugEnd()
-- augroup END
