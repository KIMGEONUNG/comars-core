-- FOR FAST SNIPPET EDITING
function StartDebug()
  vim.api.nvim_command(":w")

  vim.api.nvim_command("call vimspector#Launch()")
  local win_id = vim.g.vimspector_session_windows.code
  local buf_id = vim.fn.winbufnr(win_id)


  -- INSPECT PANNELS
  -- for i, x in pairs(vim.g.vimspector_session_windows) do
  --   print('here')
  --   print(i)
  --   print(x)
  -- end

  -- ADD KEYMAP
  -- vim.api.nvim_buf_set_keymap(buf_id, "n", "q", ":bwipe<CR>", {})
  -- vim.api.nvim_buf_set_keymap(buf_id, "n", "dl", "<Plug>VimspectorStepInto<CR>", {})
  -- vim.api.nvim_buf_set_keymap(buf_id, "n", "dk", "<Plug>VimspectorStepOut<CR>", {})
  -- vim.api.nvim_buf_set_keymap(buf_id, "n", "dj", "<Plug>VimspectorStepOver<CR>", {})

  -- DELETE KEYMAP
  -- vim.api.nvim_buf_del_keymap(buf_id, "n", "dj")
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

vim.cmd([[

fun GoToWindow(id)
    call win_gotoid(a:id)
endfun

let g:vimspector_enable_mappings = 'HUMAN'

nnoremap <leader>dd :lua StartDebug()<CR>
nnoremap <leader>de :lua ExitDebug()<CR>
nnoremap <leader>d<space> :call vimspector#Continue()<CR> 
nnoremap <leader>dtcb :call vimspector#CleanLineBreakpoint()<CR>

nmap <leader>drc <Plug>VimspectorRunToCursor
nmap <leader>dbp <Plug>VimspectorToggleBreakpoint
nmap <leader>dcbp <Plug>VimspectorToggleConditionalBreakpoint
]])

local remap = vim.keymap.set
local opt = { noremap = true, silent = true }

remap("n", "dc", ":call GoToWindow(g:vimspector_session_windows.code)<CR>", opt)
remap("n", "dt", ":call GoToWindow(g:vimspector_session_windows.tagpage)<CR>", opt)
remap("n", "dv", ":call GoToWindow(g:vimspector_session_windows.variables)<CR>", opt)
remap("n", "dw", ":call GoToWindow(g:vimspector_session_windows.watches)<CR>", opt)
remap("n", "ds", ":call GoToWindow(g:vimspector_session_windows.stack_trace)<CR>", opt)
remap("n", "do", ":call GoToWindow(g:vimspector_session_windows.output)<CR>", opt)

remap("n", "dl", "<Plug>VimspectorStepInto<CR>", opt)
remap("n", "dk", "<Plug>VimspectorStepOut<CR>", opt)
remap("n", "dj", "<Plug>VimspectorStepOver<CR>", opt)
remap("n", "db", "<Plug>VimspectorToggleBreakpoint<CR>", opt)
remap("n", "dp", ":call vimspector#Pause()<CR>", opt)
