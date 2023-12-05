require("mydebug")
require("set")
require("remap")
require("functions")
require("plugins")
require("color")
require("autocmd")

-- NAVIGATION UTILITIES
require("user.telescope")

-- LANGUAGE SERVER PROTOCOL
require("user.lsp")

-- AUTOCOMPLETE, SNIPPET
require("user.autocomplete")

-- DEBBUGER
-- require("user.vimspector")
require("user.nvimdap")

-- LATEX USING VIM
require("user.vimtex")

require("user.toggleterm")
require("user.surround")
require("user.sneak")
require("user.luasnip")
require("user.markdown")

-- TREESITTER
require("user.treesitter")

-- LAZYGIT
require("user.lazygit")

require("user.nvimtree")

require("func.execute")
require("func.vclip")

-- POST DEFINITIONS
vim.cmd([[
hi Comment guifg=red ctermfg=red gui=italic 
hi LineNr guifg=#cdb923 ctermfg=gray

set cursorline
highlight CursorLineNR guifg=yellow
]])
