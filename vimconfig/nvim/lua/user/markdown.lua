-- Create a function to define your custom mappings for Python filetype
function MarkdownCustom()
  vim.api.nvim_buf_set_keymap(0, 'n', '\\ll', ':MarkdownPreview<CR>', { noremap = true, silent = true })
end

local group = vim.api.nvim_create_augroup("MarkdownCustom", {})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  command = "lua MarkdownCustom()",
  group = group
})
