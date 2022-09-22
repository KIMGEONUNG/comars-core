vim.opt.scrolloff = 8
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

vim.opt.exrc = true

vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.expandtab = true
vim.opt.autoindent = true

vim.opt.relativenumber = true
vim.opt.nu = true

-- A "NO" PREFIX DOES NOT AVAILABLE IN THE LUA SETTING.
-- FOR EXAMPLE, WE CANNOT USE "VIM.OPT.NOWRAP = TRUE" FOR "SET NOWRAP".
-- INSTEAD, WE SHOULD USE "VIM.OPT.WRAP = FALSE"
vim.opt.wrap = true
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.errorbells = false

vim.cmd([[
set colorcolumn=80
]])

-- VISUALIZE UNVISIBLE CHARACTERS AND ELEMENTS.
vim.cmd([[
set list
set listchars+=tab:›\ 
set listchars+=trail:⋅
set listchars+=multispace:\ ⋅
]])
-- set listchars+=eol:¬
-- set listchars+=conceal:-
-- set listchars+=multispace:⋅⋅\|
-- set listchars+=lead:⋅

-- PYTHON PROVIDER (use :checkhealth)
vim.g.python3_host_prog = '/home/comar/anaconda3/bin/python3'

-- FOR SOME REASON, CERTAIN OPTIONS IN PYTHON CANNOT BE CHANGED USING A NAIVE
-- ASSIGNMENT. SO WE USE AUTOMCD TRICK LIKE BELOW.
vim.cmd([[
autocmd FileType python set shiftwidth=2
autocmd FileType python set tabstop=2
autocmd FileType python set softtabstop=2
autocmd FileType python set expandtab
]])
-- :au BufEnter *.py setlocal expandtab=True
