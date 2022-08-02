vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- PACKER CAN MANAGE ITSELF
  use 'wbthomason/packer.nvim'

  -- LSP
  use 'neovim/nvim-lspconfig'

  -- AUTOCOMPLETE
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-nvim-lsp' -- REQUIRED
  use 'hrsh7th/cmp-nvim-lua'

  -- SNIPS
  -- use 'Shougo/neosnippet.vim'
  -- use 'Shougo/neosnippet-snippets'
  -- use 'hrsh7th/cmp-vsnip'
  -- use 'hrsh7th/vim-vsnip'
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip'

  -- NAVIGATION
  use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- UI
  use 'morhetz/gruvbox'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  use 'kyazdani42/nvim-web-devicons'

  -- PREVIEW
  use 'turbio/bracey.vim' -- HTML PREVIEW
  use 'iamcco/markdown-preview.nvim'

  -- BRAKET CONTROL UTILITIES
  use 'tpope/vim-surround'

  -- COMMENT UTILITIES
  use 'tomtom/tcomment_vim'

  -- MAXIMIZES AND RESTORES THE CURRENT WINDOW IN VIM. 
  use 'szw/vim-maximizer'

  -- VIM DEBUGGER
  use 'puremourning/vimspector'

  -- NERDTREE
  use 'preservim/nerdtree'
  use 'ryanoasis/vim-devicons'
end)
