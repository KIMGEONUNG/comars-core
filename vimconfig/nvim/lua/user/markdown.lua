
-- Create a function to define your custom mappings for Python filetype
function markdown_custom_mappings()
    vim.api.nvim_buf_set_keymap(0, 'n', '\\ll', ':MarkdownPreview<CR>', {noremap = true, silent = true})
end

-- local group = vim.api.nvim_create_augroup("markdown-semantic", {})
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "markdown",
--   command = "markdown_custom_mappings()",
--   group = group
-- })

--
-- -- Create an autocmd to call the function when a Python file is loaded or its filetype is set
vim.cmd([[
  augroup markdown_filetype
    autocmd!
    autocmd FileType markdown lua markdown_custom_mappings()
  augroup END
]])
