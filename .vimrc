"tab to character
set expandtab
"tab to 4 space
set ts=4
" >> or << space count, which reflect to auto-format space count
set shiftwidth=4
"visualize line number
set nu

"=========================Plugin Sector

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

" lightline plugin config #begin
set laststatus=2
" lightline plugin config #end 

" color scheme location is /usr/share/vim/vim80/color
colorscheme jellybeans 

" autoformat key
noremap <F3> :Autoformat<CR>
"let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
"let g:autoformat_remove_trailing_spaces = 0
