-- PLUSGINS -------------------------------------------------------------------

vim.cmd([[

filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'nvim-lua/popup.nvim'
Plugin 'nvim-lua/plenary.nvim'
Plugin 'nvim-telescope/telescope.nvim'
Plugin 'nvim-telescope/telescope-fzy-native.nvim'
Plugin 'kyazdani42/nvim-web-devicons'

Plugin 'iamcco/markdown-preview.nvim'

Plugin 'neovim/nvim-lspconfig'
" Plugin 'kabouzeid/nvim-lspinstall'
Plugin 'nvim-lua/completion-nvim'

Plugin 'Shougo/neosnippet.vim'
Plugin 'Shougo/neosnippet-snippets'

Plugin 'morhetz/gruvbox'
Plugin 'kimgeonung/dracula'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

Plugin 'tpope/vim-surround'

" Maximizes and restores the current window in Vim. 
Plugin 'szw/vim-maximizer'

" vim debugger
Plugin 'puremourning/vimspector'

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" auto formatting collection
Plugin 'Chiel92/vim-autoformat'

" html previwer
Plugin 'turbio/bracey.vim'

" NerdTree
Plugin 'preservim/nerdtree'
Plugin 'ryanoasis/vim-devicons'

" html css javascript auto completion
Plugin 'mattn/emmet-vim'

" vim comment plugin
Plugin 'tomtom/tcomment_vim'

call vundle#end()            " required
filetype plugin indent on    " required

]])

