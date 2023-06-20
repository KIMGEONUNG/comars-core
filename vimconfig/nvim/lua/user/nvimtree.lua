-- examples for your init.lua

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
-- require("nvim-tree").setup()

-- OR setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 50,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})


local previous_buf_id = nil
local function NowInTree()
  -- if vim.g.vimspector_session_windows ~= nil then
  --   return false
  -- end

  local buf_id = vim.api.nvim_get_current_buf()
  local name = vim.api.nvim_buf_get_name(buf_id)
  if string.find(name, "NvimTree_") then
    return true
  else
    previous_buf_id = buf_id
    return false
  end
end

function Move2TreeOrNot()
  -- if vim.g.vimspector_session_windows ~= nil then
  --   return false
  -- end

  if NowInTree() then
    vim.api.nvim_set_current_buf(previous_buf_id)
  else
    vim.api.nvim_command("NvimTreeFocus")
  end
end

local remap = vim.keymap.set
remap('n', '<leader>T', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
remap('n', '<leader>t', ':lua Move2TreeOrNot()<CR>', { noremap = true, silent = true })
-- remap('n', '<leader>t', ':NvimTreeFocus<CR>', { noremap = true, silent = true })
