-- WIP
-- Now I attempt to build nvim-dap debugging setting.
-- Not-implemented features are as follow
-- * set unmodifiable
-- * build generator of nvim-dap config
-- * build configuration linker for nvim-dap
-- * implement run-to-cursor

Dap = {}

local dap = require('dap')
local dapui = require("dapui")

-- Note that omitting the "dapui.setup({})" invokes error.
-- This setup method has a role of initializtion
dapui.setup({})

-- As this is a recommended setting described in offical README,
-- I'm not sure what the code acually does
require("neodev").setup({
  library = { plugins = { "nvim-dap-ui" }, types = true },
})

-- ONLY FOR DEBUGGING
-- dap.set_log_level('TRACE')

dap.adapters.python = function(cb, config)
  -- print('In adapters:' .. config.request)
  if config.request == 'attach' then
    ---@diagnostic disable-next-line: undefined-field
    local port = (config.connect or config).port
    ---@diagnostic disable-next-line: undefined-field
    local host = (config.connect or config).host or '127.0.0.1'
    cb({
      type = 'server',
      port = assert(port, '`connect.port` is required for a python `attach` configuration'),
      host = host,
      options = {
        source_filetype = 'python',
      },
    })
  else
    cb({
      type = 'executable',
      command = os.getenv('HOME') .. '/anaconda3/bin/python',
      args = { '-m', 'debugpy.adapter' },
      options = {
        source_filetype = 'python',
      },
    })
  end
end

-- dap.adapters.python = {
--   type = 'executable';
--   command = os.getenv('HOME') .. '/anaconda3/bin/python';
--   -- command = os.getenv('CONDA_PREFIX') .. '/bin/python';
--   args = { '-m', 'debugpy.adapter' };
-- }

-- dap.adapters.remote_python = {
--   type = 'server';
--   host = "127.0.0.1"; -- this is the server-side host
--   port = 5678; -- this is the server-side port
-- }


-- dap.configurations.python = { {
--   name = "Launch config";
--   type = 'python';
--   request = 'launch';
--   program = "${file}";
--   pythonPath = function()
--     return os.getenv('CONDA_PREFIX') .. '/bin/python'
--   end;
-- },
-- }

-- dap.configurations.python = {
--   {
--     name = "Attach config";
--     type = 'remote_python';
--     request = 'attach';
--     port = 5678; -- this is the client-side port
--     host = "127.0.0.1";
--     pathMappings = {
--       {
--         localRoot = "${workspaceFolder}";
--         remoteRoot = ".";
--       }
--     };
--   },
-- }

-- this code should be located after the definition of configurations.<filetype>
require('dap.ext.vscode').load_launchjs('launch.json', { debugpy = { 'py' } })


-- KEYMAPS
-- vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
-- vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
-- vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
-- vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
-- vim.keymap.set('n', '<F9>', function() require('dap').toggle_breakpoint() end)


function Dap.exit()
  dap.terminate()
  dapui.close()
end

function Dap.start()
  dap.continue()
end

function Dap.move_to_element(buffer_id)
  -- first find the window for this buffer
  local win_id = nil
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_buf(win) == buffer_id then
      win_id = win
      break
    end
  end
  -- if we didn't find the window, we can't move to the buffer
  if win_id == nil then
    print('No window currently viewing buffer ' .. buffer_id)
    return
  end
  -- move to the window
  vim.api.nvim_set_current_win(win_id)
  -- now we should be viewing the buffer
end

if true then
  local opt = { noremap = true, silent = true }
  -- {hover} `(dapui.elements.hover)`
  -- code..?
  vim.keymap.set("n", "<leader>dc", function() Dap.move_to_code() end, opt)
  vim.keymap.set("n", "<leader>dw", function() Dap.move_to_element(dapui.elements.watches.buffer()) end, opt)
  vim.keymap.set("n", "<leader>do", function() Dap.move_to_element(dapui.elements.repl.buffer()) end, opt)
  vim.keymap.set("n", "<leader>dt", function() Dap.move_to_element(dapui.elements.console.buffer()) end, opt)
  vim.keymap.set("n", "<leader>ds", function() Dap.move_to_element(dapui.elements.stacks.buffer()) end, opt)
  vim.keymap.set("n", "<leader>dv", function() Dap.move_to_element(dapui.elements.scopes.buffer()) end, opt)
  vim.keymap.set("n", "<leader>db", function() Dap.move_to_element(dapui.elements.breakpoints.buffer()) end, opt)
  -- vim.api.nvim_set_keymap('n', '<leader>dp', ':call vimspector#Pause()<CR>', {})

  vim.keymap.set('n', '<leader>d<leader>', function() Dap.start() end)
  -- vim.keymap.set('n', '<leader>d<leader>', function() dap.run() end)
  vim.keymap.set('n', '<leader>de', function() Dap.exit() end)
  -- vim.keymap.set('n', '<leader>de', function() dap.terminate() end)
  vim.keymap.set('n', '<leader>bp', function() require('dap').toggle_breakpoint() end)
end


local mapped = {}
local remaps = {
  { 'n', 'dj', function() require('dap').step_over() end },
  { 'n', 'dl', function() require('dap').step_into() end },
  { 'n', 'dk', function() require('dap').step_out() end },
  { 'n', 'dp', function() require('dap').pause() end },
  { 'n', 'di', function() dapui.eval() end }
}

function Dap.SetDapSepecific()
  local opt = { noremap = true, silent = true }
  for _, v in ipairs(remaps) do
    vim.keymap.set(v[1], v[2], v[3], opt)
  end
  -- mapped[bufnr] = { modifiable = vim.api.nvim_buf_get_option(bufnr, 'modifiable') }
  -- vim.api.nvim_buf_set_option(bufnr, 'modifiable', false)
end

function Dap.DelDapSepecific()
  for _, v in ipairs(remaps) do
    local status, err = pcall(function()
      vim.keymap.del(v[1], v[2])
    end)
  end
end

Dap.window_id_code = nil

function Dap.move_to_code()
  vim.api.nvim_set_current_win(Dap.window_id_code)
end

-- LISTENER OR CALLBACKS

dap.listeners.after['event_initialized']['my-start'] = function()
  Dap.window_id_code = vim.api.nvim_get_current_win()
  Dap.SetDapSepecific()
end

dap.listeners.before['event_terminated']['my-terminate'] = function()
  Dap.window_id_code = nil
  Dap.DelDapSepecific()
end

dap.listeners.before['event_exited']['my-exited'] = function()
  Dap.window_id_code = nil
  Dap.DelDapSepecific()
end

-- required
dap.listeners.after.event_stopped["mytest"] = function() print('event stopped') end

dap.listeners.after.event_initialized["dapui_config"] = function()
  vim.api.nvim_command("NvimTreeClose")
  dapui.open()
end

-- IF UNCOMMENT, THE DAP-UI IS AUTOMATICALLY CLOSED AFTER THE PROGRAM HAS FINISHED
-- dap.listeners.before.event_terminated["dapui_config"] = function()
--   dapui.close()
-- end
-- dap.listeners.before.event_exited["dapui_config"] = function()
--   dapui.close()
-- end


-- SELECT CONFIG
function GetCommandOutput(cmd)
  local file = assert(io.popen(cmd, 'r'))
  local output = file:read('*all')
  file:close()
  return output
end

function Dap.SelectNvimdapConfig()
  local dir_config = "nvimdapconfigs"

  local function get_file_list()
    local handle = io.popen('ls ' .. dir_config)
    local result = handle:read('*a')
    handle:close()

    -- CODE SMELL START -----------------------------------------------
    local lines = vim.split(result, '\n')
    for i, v in pairs(lines) do
      if v == "" then
        table.remove(lines, i)
      end
    end
    -- CODE SMELL END -----------------------------------------------
    return lines
  end

  -- Function to display the contents of a file
  function Dap.link_config()
    local file = vim.api.nvim_get_current_line()
    local cmd = 'ln -sf ' .. dir_config .. '/' .. file .. ' launch.json'
    local a = os.execute(cmd)

    if a == 0 then
      print("Command succeeded: " .. cmd)
    end
    vim.api.nvim_command("call clearmatches()")
    vim.api.nvim_command("call matchadd('TermCursor', '\\%'.line('.').'l')")
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

  -- Adjust position for second window
  opts.col = opts.col + win_width + 3
  -- -- Create window and buffer for file contents
  local buf2 = vim.api.nvim_create_buf(false, true)
  local win2 = vim.api.nvim_open_win(buf2, true, opts)

  -- Fill buffer with file list
  local file_list = get_file_list()
  vim.api.nvim_buf_set_lines(buf1, 0, -1, false, file_list)

  -- Fill buffer with file list
  vim.api.nvim_buf_set_option(buf1, 'modifiable', false)
  vim.api.nvim_buf_set_option(buf2, 'modifiable', false)

  vim.api.nvim_set_current_win(win1)

  -- HIGHLIGHT CURRENT CONFIG
  -- 'match('([^/]+)$")' is to extract the file name from the file path
  -- 'or ""' is to make the value empty string if the value is nil
  local config_cur = GetCommandOutput("readlink launch.json"):match("([^/]+)$") or ""
  local config_cur_id = nil
  for i, line in ipairs(vim.api.nvim_buf_get_lines(buf1, 0, -1, false)) do
    if line:gsub("%s", "") == config_cur:gsub("%s", "") then
      config_cur_id = i
    end
  end
  if config_cur_id then
    vim.api.nvim_command("call matchadd('TermCursor', '\\%" .. config_cur_id .. "l')")
  end

  function Dap.on_cursor_move()
    vim.api.nvim_buf_set_option(buf2, 'modifiable', true)
    local file = vim.api.nvim_get_current_line()
    local path = dir_config .. '/' .. file
    local handle = io.open(path, 'r')
    local contents = handle:read('*a')
    handle:close()
    vim.api.nvim_buf_set_lines(buf2, 0, -1, false, vim.split(contents, '\n'))
    vim.api.nvim_buf_set_option(buf2, 'modifiable', false)
    vim.api.nvim_buf_set_option(buf2, 'filetype', 'json')
  end

  function Dap.close_all()
    vim.api.nvim_win_close(win2, true)
    vim.api.nvim_win_close(win1, true)
  end

  vim.api.nvim_create_autocmd("CursorMoved", {
    command = "lua Dap.on_cursor_move()",
    buffer = buf1,
  })

  vim.cmd("lua Dap.on_cursor_move()")

  -- Close window when any key is pressed
  vim.api.nvim_buf_set_keymap(buf1, 'n', '<CR>', '<cmd>lua Dap.link_config()<CR>', {})
  vim.api.nvim_buf_set_keymap(buf1, 'n', '<Esc>', '<cmd>lua Dap.close_all()<CR>', {})
  vim.api.nvim_buf_set_keymap(buf1, 'n', 'q', '<cmd>lua Dap.close_all()<CR>', {})

  vim.api.nvim_buf_set_keymap(buf2, 'n', '<CR>', '<cmd>lua Dap.link_config()<CR>', {})
  vim.api.nvim_buf_set_keymap(buf2, 'n', '<Esc>', '<cmd>lua Dap.close_all()<CR>', {})
  vim.api.nvim_buf_set_keymap(buf2, 'n', 'q', '<cmd>lua Dap.close_all()<CR>', {})
end

vim.api.nvim_create_user_command("SelectNvimdapConfig", 'lua Dap.SelectNvimdapConfig()', {})
vim.api.nvim_set_keymap('n', '<leader>da', ':SelectNvimdapConfig<CR>', {})
