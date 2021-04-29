""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                     /\                 .__           "
"   ____  ____   _____ _____ _______  )/   ______  ___  _|__| _____    "
" _/ ___\/  _ \ /     \\__  \\_  __ \     /  ___/  \  \/ /  |/     \   "
" \  \__(  <_> )  Y Y  \/ __ \|  | \/     \___ \    \   /|  |  Y Y  \  "
"  \___  >____/|__|_|  (____  /__|       /____  >    \_/ |__|__|_|  /  "
"      \/            \/     \/                \/                  \/   "
"                                                                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"======================================================================"
"""""""""""""""""""""""VIM BASIC SETTING""""""""""""""""""""""""""""""""
"======================================================================"

set noerrorbells

let mapleader = " "
set scrolloff=8
set incsearch
set hlsearch
set expandtab
set ts=4
set shiftwidth=4
set autoindent

set relativenumber
set nu

set hidden
set nowrap
set nobackup
set noswapfile
set undodir=~/.vim/undodir
set undofile

" set colorcolumn=80

" scheme location is /usr/share/vim/vim80/color
colorscheme gruvbox 
set background=dark
let g:gruvbox_contrast_dark ='medium'

nnoremap <Leader>n :bn<CR>
nnoremap <Leader>b :bf<CR>

nnoremap <Leader>h :wincmd h<CR>
nnoremap <Leader>j :wincmd j<CR>
nnoremap <Leader>k :wincmd k<CR>
nnoremap <Leader>l :wincmd l<CR>
"======================================================================"
"======================================================================"


"======================================================================"
"""""""""""""""""""""""""""PLUGIN SECTOR""""""""""""""""""""""""""""""""
"======================================================================"

packadd! gruvbox
packadd! vim-airline
packadd! vim-airline-themes

filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()


" Maximizes and restores the current window in Vim. 
Plugin 'szw/vim-maximizer'
" vim debugger
Plugin 'puremourning/vimspector'
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" statusline/tabline
Plugin 'itchyny/lightline.vim'
" auto formatting collection
Plugin 'Chiel92/vim-autoformat'
" auto complete tool
Plugin 'ycm-core/YouCompleteMe'
" html previwer
Plugin 'turbio/bracey.vim'
" NerdTree
Plugin 'preservim/nerdtree'
" html css javascript auto completion
Plugin 'mattn/emmet-vim'
" programming language syntax checker
Plugin 'scrooloose/syntastic'
" vim snippet sets. two plugin need each other
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

" find files
Plugin 'kien/ctrlp.vim'

" vim comment plugin
" shortcut is 'gc'
Plugin 'tomtom/tcomment_vim'

call vundle#end()            " required
filetype plugin indent on    " required

" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"======================================================================"
"======================================================================"
"======================================================================"
"TCOMMENT=============================================================="
"======================================================================"
map <c-k> <s-v>gc
"======================================================================"
"======================================================================"
"
"======================================================================"
"LIGHTLINE============================================================="
"======================================================================"


"======================================================================"
"AIRLINE==============================================================="
"======================================================================"

let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='gruvbox'
let g:airline_powerline_fonts = 1
"
" let g:airline#extensions#tabline#show_close_button = 0
"if !exists('g:airline_symbols')
"    let g:airline_symbols = {}
"endif
"
"" unicode symbols
"let g:airline_left_sep = '»'
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '«'
"let g:airline_right_sep = '◀'
"let g:airline_symbols.linenr = '␊'
"let g:airline_symbols.linenr = '␤'
"let g:airline_symbols.linenr = '¶'
"let g:airline_symbols.branch = '⎇'
"let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = 'Þ'
"let g:airline_symbols.paste = '∥'
"let g:airline_skip_empty_sections = 1

"======================================================================"
"======================================================================"
"
"======================================================================"
"LIGHTLINE============================================================="
"======================================================================"
" set laststatus=2

"======================================================================"
"======================================================================"

"======================================================================"
"VIM-AUTOFORMAT========================================================"
"======================================================================"
noremap <F3> :Autoformat<CR>
let g:autoformat_retab = 0
"======================================================================"
"======================================================================"

"======================================================================"
"NERD-TREE============================================================="
"======================================================================"
map <C-n> :NERDTreeToggle<CR>
"======================================================================"
"======================================================================"

"======================================================================"
"BRACEY================================================================"
"======================================================================"
" default command: bracey

map <F2> :Bracey<CR>
"======================================================================"
"======================================================================"

"======================================================================"
"Ultisnips============================================================="
"======================================================================"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsEditSplit="vertical"
"======================================================================"
"======================================================================"

"======================================================================"
"EMMET-VIM============================================================="
"======================================================================"
" default shortcut: <c-y>,
"======================================================================"
"======================================================================"

"======================================================================"
"YOU_COMPLETE_ME======================================================="
"======================================================================"
" default shortcut(edit mode): <c-n>

"  The default value is ['<tab>', '<down>']. If so, snippet shortcut key <tab>
" would not work. So I remap <tab> into <UP>.
let g:ycm_key_list_select_completion = ['<UP>', '<Down>']
nnoremap <Leader>gd :YcmCompleter GoTo<CR>
"======================================================================"
"======================================================================"

"======================================================================"
"SYNTASTIC============================================================="
"======================================================================"
"
" See the manual for details about the corresponding supported checkers (:help syntastic-checkers in Vim).
" Javascript setting vedio : https://www.youtube.com/watch?v=0uw96oNqKRo
"
" javascript :jshin
" html: tidy
"
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_quiet_messages = { 'regex': 'ES6' }

"map <Leader>s :SyntasticToggleMode<CR>
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 0
"let g:syntastic_check_on_open = 0
"let g:syntastic_check_on_wq = 0

"======================================================================"
"======================================================================"

"======================================================================"
"VIMSPECTOR============================================================"
"======================================================================"

fun GoToWindow(id)
    call win_gotoid(a:id)
endfun

let g:vimspector_enable_mappings = 'HUMAN'

nnoremap <leader>dd :call vimspector#Launch()<CR>
nnoremap <leader>dc :call GoToWindow(g:vimspector_session_windows.code)<CR>
nnoremap <leader>dt :call GoToWindow(g:vimspector_session_windows.tagpage)<CR>
nnoremap <leader>dv :call GoToWindow(g:vimspector_session_windows.variables)<CR>
nnoremap <leader>dw :call GoToWindow(g:vimspector_session_windows.watches)<CR>
nnoremap <leader>ds :call GoToWindow(g:vimspector_session_windows.stack_trace)<CR>
nnoremap <leader>do :call GoToWindow(g:vimspector_session_windows.output)<CR>
nnoremap <leader>de :call vimspector#Reset()<CR>

nnoremap <leader>dtcb :call vimspector#CleanLineBreakpoint()<CR>

nmap <leader>dl <Plug>VimspectorStepInto 
nmap <leader>dj <Plug>VimspectorStepOver
nmap <leader>dk <Plug>VimspectorStepOut
nmap <leader>d_ <Plug>VimspectorRestart
nnoremap <leader>d<space> :call vimspector#Continue()<CR> 

nmap <leader>drc <Plug>VimspectorRunToCursor
nmap <leader>dbp <Plug>VimspectorToggleBreakpoint
nmap <leader>dcbp <Plug>VimspectorToggleConditionalBreakpoint
"======================================================================"

"======================================================================"
"CTRLP================================================================="
"======================================================================"
let g:ctrlp_user_command = []
let g:ctrlp_use_caching = 0

"======================================================================"

"======================================================================"
"ULTI_SNIPS============================================================"
"======================================================================"
let g:UltiSnipsExpandTrigger="<tab>"
"======================================================================"
