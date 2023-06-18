local dap = require('dap')
local dapui = require("dapui")

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

dap.configurations.python = {
  {
    name = "Attach config";
    type = 'remote_python';
    request = 'attach';
    port = 7777; -- this is the client-side port
    host = "127.0.0.1";
    pathMappings = {
      {
        localRoot = "${workspaceFolder}";
        remoteRoot = ".";
      }
    };
  },
}

-- this code should be located after the definition of configurations.<filetype>
require('dap.ext.vscode').load_launchjs('launch.json', { debugpy = { 'py' } })

vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
vim.keymap.set('n', '<F9>', function() require('dap').toggle_breakpoint() end)

-- require("neodev").setup({
--   library = { plugins = { "nvim-dap-ui" }, types = true },
-- })

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
