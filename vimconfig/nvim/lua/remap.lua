local remap = vim.keymap.set

remap('n', '<space>', '<nop>', {})
vim.g.mapleader=" "

-- WORK IN QUICK FIX LIST
remap('n', '<c-j>', ':cnext<CR>', { noremap = true, silent = true })
remap('n', '<c-k>', ':cprevious<CR>', { noremap = true, silent = true })

-- HORIZONTAL NAVIGATION
remap('n', '<leader>gs', '^', { noremap = true, silent = true })
remap('n', '<leader>ge', '$', { noremap = true, silent = true })

-- VERTICAL NAVIGATION
remap({'n', 'v' }, '<c-u>', '10kzz', { noremap = true, silent = true })
remap({'n', 'v' }, '<c-d>', '10jzz', { noremap = true, silent = true })

-- POSITIONAL NAVIGATION
remap('n', '<c-o>', '<c-o>zz', { noremap = true, silent = true })
remap('n', '<c-i>', '<c-i>zz', { noremap = true, silent = true })

-- WINDOW NAVIGATION
remap('n', '<leader>h', ':wincmd h<CR>', { noremap = true, silent = true })
remap('n', '<leader>j', ':wincmd j<CR>', { noremap = true, silent = true })
remap('n', '<leader>k', ':wincmd k<CR>', { noremap = true, silent = true })
remap('n', '<leader>l', ':wincmd l<CR>', { noremap = true, silent = true })

-- WINDOW RESIZE
remap('n', '<leader>0', ':resize +10<cr>', { noremap = true, silent = true })
remap('n', '<leader>9', ':resize -10<cr>', { noremap = true, silent = true })
remap('n', '<leader>=', ':vertical resize +10<cr>', { noremap = true, silent = true })
remap('n', '<leader>-', ':vertical resize -10<cr>', { noremap = true, silent = true })

-- READ, WRITE, EXECUTE
remap('n', '<leader>w', ':w<cr>', { noremap = true, silent = false })
remap('n', '<leader>q', ':q<cr>', { noremap = true, silent = false })
remap('n', '<leader>e', ':call ExecuteFile(expand(\'%:t\'))<CR>',
{ noremap = true, silent = false })
remap('n', '<leader>E', ':call ExecutePredef()<CR>',
{ noremap = true, silent = false })

-- BUFFER CONTORL
remap('n', '<leader>bn', ':bn<CR>', { noremap = true, silent = true })
remap('n', '<leader>bp', ':bp<CR>', { noremap = true, silent = true })
remap('n', '<leader>bw', ':bw<CR>', { noremap = true, silent = true })
vim.cmd([[
" close all buffers except current one
command! BufCurOnly execute '%bd|e#'
nnoremap <Leader>bd :BufCurOnly<CR>
]])

-- KEEPING IT CENTERED
remap('n', 'n', 'nzz', { noremap = true, silent = true })
remap('n', 'N', 'Nzz', { noremap = true, silent = true })
remap('n', 'J', "mzJ'z", { noremap = true, silent = true })

-- ETC
remap('n', '<leader>nh', ':nohlsearch<CR>', { noremap = true, silent = true })
remap('n', 'ci,', ':call DeleteInnerArg()<CR>', { noremap = true, silent = true })
remap({ 'n', 'i', 'v', 'c' }, '<c-q>', '<esc>', { noremap = true, silent = true })

-- remap('n', '<c-f>,', 'W', { noremap = true, silent = true })
-- remap('n', '<c-b>,', 'B', { noremap = true, silent = true })
-- remap('n', '<c-e>,', '$h', { noremap = true, silent = true })

remap('n', 'Y', 'y$', { noremap = true, silent = true })

-- UNKNOWN OR ARCHIVE
--
-- nnoremap <C-e> <ESC>$
-- vnoremap J :m '>+1<CR>gv=gv
-- vnoremap K :m '<-2<CR>gv=gv
--
-- inoremap <C-@> <C-x><C-o>
--
-- " UNDO BREAK POINTS
-- inoremap , ,<c-g>u
-- inoremap . .<c-g>u
-- inoremap ! !<c-g>u
-- inoremap ? ?<c-g>u
--
-- " JUMPLIST MUTATION
-- nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
-- nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

-- " inoremap <C-a> <C-o>^
-- inoremap <C-e> <C-o>$
-- inoremap <C-f> <C-o>W
-- inoremap <C-b> <C-o>B
-- inoremap <C-l> <C-o>l
