syntax on
set number
set numberwidth=2
set autoindent
set cindent 
"
" Indentation size
set ts=4
set shiftwidth=4

colorscheme jellybeans

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugs' }

Plug 'zchee/deoplete-clang'

Plug 'artur-shaik/vim-javacomplete2'
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'
Plug 'https://github.com/tpope/vim-surround.git'
Plug 'https://github.com/tomtom/tcomment_vim.git'
Plug 'https://github.com/vim-syntastic/syntastic.git'
Plug 'https://github.com/scrooloose/nerdtree.git'
Plug 'itchyny/lightline.vim'
Plug 'maksimr/vim-jsbeautify'
Plug 'davidhalter/jedi-vim'
call plug#end()

" Turn off the include path error message
let g:syntastic_quiet_messages = { 'regex': "No such file or directory" }

let g:deoplete#enable_at_startup = 1

let g:deoplete#sources#clang#libclang_path ="/usr/lib/llvm-6.0/lib/libclang-6.0.so.1"
let g:deoplete#sources#clang#clang_header ="/usr/lib/clang/"
let g:deoplete#sources#clang#std ={'c': 'c11', 'cpp': 'c++1z', 'objc': 'c11', 'objcpp': 'c++1z'}

let g:JavaComplete_EnableDefaultMappings = 0

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0 

map <C-n> :NERDTreeToggle<CR>
" map <c-f> :call JsBeautify()<cr>

autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
" for json
autocmd FileType json noremap <buffer> <c-f> :call JsonBeautify()<cr>
" for jsx
autocmd FileType jsx noremap <buffer> <c-f> :call JsxBeautify()<cr>
" for html
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
" for css or scss
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>
