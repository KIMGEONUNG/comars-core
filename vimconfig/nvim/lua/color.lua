-- COLORSCHEME
-- vim.cmd[[colorscheme tokyonight-night]]
-- vim.cmd[[colorscheme tokyonight-storm]]
-- vim.cmd[[colorscheme catppuccin]]
-- vim.cmd[[colorscheme nordic]]
--
vim.cmd[[colorscheme nord]]

local C = require 'nordic.colors'
require('nordic').setup {
  -- For some reason, this override does not work. So I change it to the original code.
  override = {
    CursorLine = {
      bg = C.gray2,
      bold = true -- Or false.
    },
    Visual = {
      bg = C.gray3,
      bold = true -- Or false.
    }
  },
}
-- This should be located after setup.
require('nordic').load()

-- AIRLINE
vim.cmd([[let g:airline#extensions#tabline#enabled = 1]])
vim.cmd([[let g:airline_theme='nord']])
-- vim.cmd([[let g:airline_theme='nord_minimal']])
-- vim.cmd([[let g:airline_theme='deus']])
vim.cmd([[let g:airline_powerline_fonts = 1]])
