vim.cmd([[

" # SCHEME====================================================================
set termguicolors
let g:gruvbox_contrast_dark = 'dark'
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
let g:gruvbox_invert_selection='0'
colorscheme gruvbox 
set background=dark

]])
