require("my.opts")
require("my.functions")
require("my.maps")
require("plugins")
require("my.scheme")
require("my.debug")

-- NAVIGATION UTILITIES
require("popts.telescope")

-- LANGUAGE SERVER PROTOCOL
require("popts.lsp")

-- AUTOCOMPLETE, SNIPPET
require("popts.autocomplete")
-- require("popts.snippet")

-- DEBBUGER
-- require("popts.vimspector")

--- ETC -----------------------------------------------------------------------
vim.cmd([[

" # NERD-TREE=================================================================
map <C-n> :NERDTreeToggle<CR>
" set guifont=DroidSansMono\ Nerd\ Font\ 11

]])
