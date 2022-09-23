
-- FOR SOME REASON, CERTAIN OPTIONS IN PYTHON CANNOT BE CHANGED USING A NAIVE
-- ASSIGNMENT. SO WE USE AUTOMCD TRICK LIKE BELOW.
vim.cmd([[
autocmd FileType python set shiftwidth=2
autocmd FileType python set tabstop=2
autocmd FileType python set softtabstop=2
autocmd FileType python set expandtab
]])
-- :au BufEnter *.py setlocal expandtab=True

--  RELOAD SNIPPETS CHANGED
vim.api.nvim_create_autocmd("TabClosed", { command = "lua RefreshSnippet()" })
