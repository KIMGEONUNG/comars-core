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

" seach highlighting simultaneously
set incsearch
" highlight search matches
set hlsearch
" tab to character
set expandtab
" tab to 4 space
set ts=4
" >> or << space count, which reflect to auto-format space count
set shiftwidth=4
" visualize line number
set nu
" scheme location is /usr/share/vim/vim80/color
colorscheme jellybeans 

"======================================================================"
"======================================================================"


"======================================================================"
"""""""""""""""""""""""""""PLUGIN SECTOR""""""""""""""""""""""""""""""""
"======================================================================"

set nocompatible              " be iMproved, required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

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

" copy paste buffer
Plugin 'rosenfeld/conque-term'

" vim snippet sets. two plugin need each other
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

call vundle#end()            " required
filetype plugin indent on    " required
set autoindent
 
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
"LIGHTLINE============================================================="
"======================================================================"
set laststatus=2
"======================================================================"
"======================================================================"

"======================================================================"
"VIM-AUTOFORMAT========================================================"
"======================================================================"
noremap <F3> :Autoformat<CR>
"let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
"let g:autoformat_remove_trailing_spaces = 0
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

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
"======================================================================"
"======================================================================"

"======================================================================"
"ULTI_SNIPS============================================================"
"======================================================================"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="vertical"
"======================================================================"
"======================================================================"
