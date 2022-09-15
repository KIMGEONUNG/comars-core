
vim.cmd([[

autocmd FileType python let b:surround_{char2nr('p')} = "print(\r)"

autocmd FileType tex let b:surround_{char2nr('b')} = "{\\bf \r}"
autocmd FileType tex let b:surround_{char2nr('i')} = "{\\it \r}"

]])

