
vim.cmd([[
if !empty(matchstr(expand('%:t'), '.py$'))
  let b:surround_{char2nr('p')} = "print(\r)"
elseif !empty(matchstr(expand('%:t'), '.tex$'))
  let b:surround_{char2nr('b')} = "{\\bf \r}"
  let b:surround_{char2nr('i')} = "{\\it \r}"
endif
]])
