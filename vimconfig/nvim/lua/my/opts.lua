vim.opt.scrolloff=8
vim.opt.ts=4
vim.opt.shiftwidth=4

vim.opt.exrc = true

vim.opt.incsearch = true 
vim.opt.hlsearch = true
vim.opt.expandtab = true
vim.opt.autoindent = true

vim.opt.relativenumber = true
vim.opt.nu = true

-- A "no" prefix does not available in the lua setting.
-- For example, we cannot use "vim.opt.nowrap = true" for "set nowrap".
-- Instead, we should use "vim.opt.wrap = false"
vim.opt.wrap = false
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.errorbells = false

vim.cmd([[
set colorcolumn=80
]])

-- PYTHON PROVIDER (use :checkhealth)
vim.g.python3_host_prog = '/home/comar/anaconda3/bin/python3'
