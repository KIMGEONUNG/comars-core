-- examples for your init.lua
vim.cmd([[
    :hi      NvimTreeExecFile    guifg=#ffa0a0
    :hi      NvimTreeSpecialFile guifg=#ff80ff gui=underline
    :hi      NvimTreeSymlink     guifg=Yellow  gui=italic
    :hi link NvimTreeImageFile   Title
]])

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
    width = 40,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})


local previous_win_id = nil

local function nowInTree()
  -- if vim.g.vimspector_session_windows ~= nil then
  --   return false
  -- end
  local buf_id = vim.api.nvim_get_current_buf()
  local win_id = vim.api.nvim_get_current_win()
  local name = vim.api.nvim_buf_get_name(buf_id)
  if string.find(name, "NvimTree_") then
    return true
  else
    previous_win_id = win_id
    return false
  end
end

vim.keymap.set('n', '<leader>T', function()
  vim.api.nvim_command("NvimTreeToggle")
end, { noremap = true })

vim.keymap.set('n', '<leader>t', function()
  if nowInTree() then
    vim.api.nvim_set_current_win(previous_win_id)
  else
    vim.api.nvim_command("NvimTreeFocus")
  end
end, { noremap = true })
