
-- PYTHON-SPECIFIC
vim.cmd([[
autocmd FileType python let b:surround_{char2nr('p')} = "print(\r)"
]])

-- LATEX-SPECIFIC
vim.cmd([[
autocmd FileType tex let b:surround_{char2nr('b')} = "{\\bf \r}"
autocmd FileType tex let b:surround_{char2nr('i')} = "{\\it \r}"
]])

-- BASH
vim.cmd([[

autocmd FileType sh let b:surround_{char2nr('v')} = "${\r}"

]])
