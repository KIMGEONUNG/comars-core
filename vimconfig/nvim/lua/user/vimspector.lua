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


function GoToWindow(id)
    vim.fn.win_gotoid(id)
end

vim.g.vimspector_enable_mappings = 'HUMAN'

vim.api.nvim_set_keymap('n', '<leader>dd', '<Cmd>lua StartDebug()<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>de', '<Cmd>lua ExitDebug()<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>d<space>', ':call vimspector#Continue()<CR>', {})
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

local mapped = {}
local remaps = {
  { "n", "dl", "<Plug>VimspectorStepInto<CR>", },
  { "n", "dk", "<Plug>VimspectorStepOut<CR>", },
  { "n", "dj", "<Plug>VimspectorStepOver<CR>", },
  { "n", "db", "<Plug>VimspectorToggleBreakpoint<CR>", },
  { "n", "dp", ":call vimspector#Pause()<CR>", },

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
  print(err)
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

vim.cmd([[
augroup TestCustomMappings
  au!
  autocmd User VimspectorJumpedToFrame lua OnJumpToFrame()
  autocmd User VimspectorDebugEnded ++nested lua OnDebugEnd()
augroup END
]])
