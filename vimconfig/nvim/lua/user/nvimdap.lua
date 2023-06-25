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
-- The setup method has a role of initializtion
dapui.setup({})

-- As this is a recommended setting described in offical README,
-- I'm not sure what the code acually does
require("neodev").setup({
  library = { plugins = { "nvim-dap-ui" }, types = true },
})

-- ONLY FOR DEBUGGING
-- dap.set_log_level('TRACE')

dap.adapters.python = {
  type = 'executable';
  command = os.getenv('HOME') .. '/anaconda3/bin/python';
  args = { '-m', 'debugpy.adapter' };
}

dap.configurations.python = { {
  name = "Launch config";
  type = 'python';
  request = 'launch';
  program = "${file}";
  pythonPath = function()
    return os.getenv('HOME') .. '/anaconda3/bin/python'
  end;
},
}

dap.adapters.remote_python = {
  type = 'server';
  host = 'localhost'; -- this is the server-side host
  port = 5715; -- this is the server-side port
}

-- dap.configurations.python = {
--   {
--     name = "Attach config";
--     type = 'remote_python';
--     request = 'attach';
--     port = 7777; -- this is the client-side port
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

Dap.window_id_code = nil

local mapped = {}
local remaps = {
  { 'n', 'dj', function() require('dap').step_over() end },
  { 'n', 'dk', function() require('dap').step_into() end },
  { 'n', 'dl', function() require('dap').step_out() end },
  { 'n', 'di', function() dapui.eval() end }
}


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

function Dap.move_to_code()
  vim.api.nvim_set_current_win(Dap.window_id_code)
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

  vim.keymap.set('n', '<leader>d<leader>', function() dap.continue() end)
  vim.keymap.set('n', '<leader>de', function() dap.terminate() end)
  vim.keymap.set('n', '<leader>bp', function() require('dap').toggle_breakpoint() end)
end

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
dap.listeners.after.event_stopped["mytest"] = function () print('event stopped') end 

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
