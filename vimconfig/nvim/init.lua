require("my.opts")
require("my.functions")
require("my.maps")
require("my.plugins")
require("my.scheme")
require("my.debug")

require("popts.vimspector")
require("popts.telescope")
require("popts.lsp")

--- ETC -----------------------------------------------------------------------
vim.cmd([[

" # AIRLINE===================================================================
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='gruvbox'
let g:airline_powerline_fonts = 1

" # VIM-AUTOFORMAT============================================================
noremap <F3> :Autoformat<CR>
let g:autoformat_retab = 0

" # NERD-TREE=================================================================
map <C-n> :NERDTreeToggle<CR>
" set guifont=DroidSansMono\ Nerd\ Font\ 11

" # BRACEY====================================================================
" default command: bracey
map <F2> :Bracey<CR>

]])
