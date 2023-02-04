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

nnoremap <leader>dc :call GoToWindow(g:vimspector_session_windows.code)<CR>
nnoremap <leader>dt :call GoToWindow(g:vimspector_session_windows.tagpage)<CR>
nnoremap <leader>dv :call GoToWindow(g:vimspector_session_windows.variables)<CR>
nnoremap <leader>dw :call GoToWindow(g:vimspector_session_windows.watches)<CR>
nnoremap <leader>ds :call GoToWindow(g:vimspector_session_windows.stack_trace)<CR>
nnoremap <leader>do :call GoToWindow(g:vimspector_session_windows.output)<CR>
nnoremap <leader>dp :call vimspector#Pause()<CR>

nnoremap <leader>dtcb :call vimspector#CleanLineBreakpoint()<CR>

nmap <leader>dl <Plug>VimspectorStepInto<CR>
nmap <leader>dk <Plug>VimspectorStepOut<CR>
nmap <leader>dj <Plug>VimspectorStepOver<CR>
nmap <leader>d_ <Plug>VimspectorRestart<CR>
nnoremap <leader>d<space> :call vimspector#Continue()<CR> 

nmap <leader>drc <Plug>VimspectorRunToCursor
nmap <leader>dbp <Plug>VimspectorToggleBreakpoint
nmap <leader>dcbp <Plug>VimspectorToggleConditionalBreakpoint

]])
