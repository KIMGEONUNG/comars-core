local dap = require('dap')
local dapui = require("dapui")

dap.adapters.python = {
  type = 'executable';
  command = os.getenv('HOME') .. '/anaconda3/bin/python';
  args = { '-m', 'debugpy.adapter' };
}

dap.configurations.python = {
  {
    type = 'python';
    request = 'launch';
    name = "Launch file";
    program = "${file}";
    pythonPath = function()
      return os.getenv('HOME') .. '/anaconda3/bin/python'
    end;
  },
}

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
