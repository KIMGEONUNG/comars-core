require("mydebug")
require("set")
require("remap")
require("functions")
require("plugins")
require("color")
require("autocmd")

require("func.execute")

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

-- This is for LLM-LS. I failed to setup for it. There are too abstract document,
-- And I think, It is a little in WIP.
-- require("user.copilot")
require("user.gen")
require("user.chatgpt") -- In test

-- require("user.condicon")
-- require("user.devicons")


-- POST DEFINITIONS
vim.cmd([[
hi Comment guifg=red ctermfg=red gui=italic 
hi LineNr guifg=#cdb923 ctermfg=gray

set cursorline
highlight CursorLineNR guifg=yellow
]])
