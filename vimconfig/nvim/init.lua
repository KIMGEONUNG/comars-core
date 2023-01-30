require("set")
require("remap")
require("functions")
require("plugins")
require("color")
require("debug")
require("autocmd")

-- NAVIGATION UTILITIES
require("user.telescope")

-- LANGUAGE SERVER PROTOCOL
require("user.lsp")

-- AUTOCOMPLETE, SNIPPET
require("user.autocomplete")

-- DEBBUGER
require("user.vimspector")

-- LATEX USING VIM
require("user.vimtex")

require("user.toggleterm")
require("user.surround")
require("user.sneak")
require("user.luasnip")

-- TREESITTER
require("user.treesitter")

require("func.execute")
require("func.vclip")

-- POST DEFINITIONS
vim.cmd([[
hi Comment guifg=red ctermfg=red gui=italic 
hi LineNr guifg=#cdb923 ctermfg=gray

set cursorline
highlight CursorLineNR guifg=yellow
]])
