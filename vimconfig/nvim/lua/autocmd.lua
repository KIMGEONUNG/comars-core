-- FOR SOME REASON, CERTAIN OPTIONS IN PYTHON CANNOT BE CHANGED USING A NAIVE
-- ASSIGNMENT. SO WE USE AUTOMCD TRICK LIKE BELOW.
local group = vim.api.nvim_create_augroup("Python-semantic", {})
local cmds4python = {
  "set shiftwidth=4",
  "set softtabstop=4",
  "set expandtab",
  "set tabstop=4"
}

for _, x in pairs(cmds4python) do
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    command = x,
    group = group
  })
end
