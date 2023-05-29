-- My intention of this implementation is for esay vim debug environment.
-- The desired debugging stpe is as follows.
-- 1. If the current filename has extention *.debugvim, then debugging only
--   keymapping would be activated. One for debugging function, the other for
--   script update.
-- 2. Ctr+a keymapping is for executing debugging function.
-- 3. Ctr+s keymapping would update modified script. The target script must be
-- .nvimrc file with current working directory.

function MyDebug()
  print('default debug function')
end

if not (vim.fn.matchstr(vim.fn.expand('%:t'), '.debugvim$') == "") then
  vim.api.nvim_set_keymap('n', '<c-a>', ':lua MyDebug()<cr>', {})
  vim.api.nvim_set_keymap('v', '<c-a>', ':lua MyDebug()<cr>', {})
  vim.api.nvim_set_keymap('n', '<c-s>', ':source .nvimrc<cr>', {})
end
