-- WIP 
-- Now I attempt to build nvim-dap debugging setting.
-- Not-implemented features are as follow
-- * save and load of window identifier for code
-- * debug only keymap (This feature has low priority if we use FX key mapping)
-- * build generator of nvim-dap config
-- * build configuration linker for nvim-dap

Dap = {}

local dap = require('dap')
local dapui = require("dapui")
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

vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
vim.keymap.set('n', '<F9>', function() require('dap').toggle_breakpoint() end)

function Dap.move_to_buffer(buffer_id)
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

if false then
  local opt = { noremap = true, silent = true }
  -- {hover} `(dapui.elements.hover)`
  -- code..?
  vim.keymap.set("n", "<leader>dw", function() Dap.move_to_buffer(dapui.elements.watches.buffer()) end, opt)
  vim.keymap.set("n", "<leader>do", function() Dap.move_to_buffer(dapui.elements.repl.buffer()) end, opt)
  vim.keymap.set("n", "<leader>dt", function() Dap.move_to_buffer(dapui.elements.console.buffer()) end, opt)
  vim.keymap.set("n", "<leader>ds", function() Dap.move_to_buffer(dapui.elements.stacks.buffer()) end, opt)
  vim.keymap.set("n", "<leader>dv", function() Dap.move_to_buffer(dapui.elements.scopes.buffer()) end, opt)
  vim.keymap.set("n", "<leader>db", function() Dap.move_to_buffer(dapui.elements.breakpoints.buffer()) end, opt)

  vim.keymap.set('n', 'di', function() dapui.eval() end)
  vim.keymap.set('n', '<leader>d<leader>', function() require('dap').continue() end)

  vim.keymap.set('n', 'dj', function() require('dap').step_over() end)
  vim.keymap.set('n', 'dk', function() require('dap').step_into() end)
  vim.keymap.set('n', 'dl', function() require('dap').step_out() end)
  vim.keymap.set('n', '<leader>dbp', function() require('dap').toggle_breakpoint() end)

end

-- Note that omitting the "dapui.setup({})" invokes error.
-- The setup method has a role of initializtion
dapui.setup({})

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
