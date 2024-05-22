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
  use 'L3MON4D3/LuaSnip' -- SNIPPET FRAMEWORK
  use 'saadparwaiz1/cmp_luasnip' -- CONNECT LUASNIP TO NVIM-CMP
  use "rafamadriz/friendly-snippets" -- SNIPPETS COLLECTION

  -- NAVIGATION
  use {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  use 'nvim-tree/nvim-tree.lua'
  use 'kyazdani42/nvim-web-devicons'

  -- UI
  use 'morhetz/gruvbox'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  use 'folke/tokyonight.nvim'
  use { "catppuccin/nvim", as = "catppuccin" }

  -- PREVIEW
  use 'turbio/bracey.vim' -- HTML PREVIEW
  use { 'iamcco/markdown-preview.nvim', run = 'cd app && ./install.sh' }

  -- BRAKET CONTROL UTILITIES
  use 'tpope/vim-surround'
  use 'Raimondi/delimitMate' -- AUTO BRACE CLOSING

  -- COMMENT UTILITIES
  use 'tomtom/tcomment_vim'

  -- MAXIMIZES AND RESTORES THE CURRENT WINDOW IN VIM.
  use 'szw/vim-maximizer'

  -- VIM DEBUGGER
  use 'puremourning/vimspector'
  use 'mfussenegger/nvim-dap'
  use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }
  use "folke/neodev.nvim"

  -- NERDTREE
  -- use 'preservim/nerdtree'
  -- use 'ryanoasis/vim-devicons'

  -- LATEX WITH VIM
  use 'lervag/vimtex'

  -- GIT
  use 'mhinz/vim-signify' -- SIGN COLUMN TO INDICATE MODIFIED LINES
  use 'tpope/vim-fugitive' -- GIT COMMAND IN VIM
  use 'tpope/vim-rhubarb' -- FAST URL OPEN WITH :GBrowse
  use 'junegunn/gv.vim' -- SHOW COMMIT BROWSER WITH :GV

  -- FILESYSTEM : FILE ADD, REMOVE, RENAME
  use 'tpope/vim-eunuch'

  -- VIM IN TERMINAL
  use 'akinsho/toggleterm.nvim'

  -- TEXT NAVIGATION
  use 'justinmk/vim-sneak'

  -- LAZYGIT IN VIM
  use 'kdheepak/lazygit.nvim'


  -- TREESITTER
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  -- use 'p00f/nvim-ts-rainbow'
  --
  use 'mortepau/codicons.nvim'

  -- COPILOT
  -- use 'huggingface/llm.nvim'
  use "David-Kunz/gen.nvim"

end)
