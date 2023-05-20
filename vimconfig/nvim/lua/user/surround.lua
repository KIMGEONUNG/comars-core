local group = vim.api.nvim_create_augroup("CustomSurround", { clear = true })

-- PYTHON 
vim.api.nvim_create_autocmd("Filetype", {
  pattern = "python",
  command = "let b:surround_{char2nr('p')} = \"print(\\r)\"",
  group = group,
})

-- LATEX-SPECIFIC
vim.api.nvim_create_autocmd("Filetype", {
  pattern = "tex",
  command = "let b:surround_{char2nr('b')} = \"{\\\\bf \\r}\"",
  group = group,
})
vim.api.nvim_create_autocmd("Filetype", {
  pattern = "tex",
  command = "let b:surround_{char2nr('i')} = \"{\\\\if \\r}\"",
  group = group,
})

-- BASH
vim.api.nvim_create_autocmd("Filetype", {
  pattern = "tex",
  command = "let b:surround_{char2nr('v')} = \"${\\r}\"",
  group = group,
})
