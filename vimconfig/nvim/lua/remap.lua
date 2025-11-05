local remap = vim.keymap.set

remap('n', '<space>', '<nop>', {})
vim.g.mapleader = " "

-- START SEARCH FROM THE CURRENT CURSOR
remap('n', '#', '#N', { noremap = true, silent = true })

-- MOVE CURSOR BASED ON DISPLAY LINE WHEN WE USE WRAP OPTION
remap('n', 'j', 'gj', { noremap = true, silent = true })
remap('n', 'k', 'gk', { noremap = true, silent = true })

-- DELETE A WORD IN INSERT MODE
remap('i', '<c-d>', '<c-w>', { noremap = true, silent = true })

-- WORK IN QUICK FIX LIST
remap('n', '<c-j>', ':cnext<CR>', { noremap = true, silent = true })
remap('n', '<c-k>', ':cprevious<CR>', { noremap = true, silent = true })

-- HORIZONTAL NAVIGATION
remap('n', '<leader>gs', '^', { noremap = true, silent = true })
remap('n', '<leader>ge', '$', { noremap = true, silent = true })

-- VERTICAL NAVIGATION
remap({ 'n', 'v' }, '<c-u>', '10kzz', { noremap = true, silent = true })
remap({ 'n', 'v' }, '<c-d>', '10jzz', { noremap = true, silent = true })

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
remap('n', '<leader>w', function() vim.api.nvim_command('write!') end, { noremap = true, silent = false })
remap('n', '<leader>q', ':lua Quit()<cr>', { noremap = true, silent = true })
remap('n', '<leader>Q', ':lua QuitF()<cr>', { noremap = true, silent = false })


-- BUFFER CONTORL
remap('n', '<S-l>', ':bnext<CR>', { noremap = true, silent = true })
remap('n', '<S-h>', ':bprevious<CR>', { noremap = true, silent = true })
remap('n', '<leader>bw', ':bwipe<CR>', { noremap = true, silent = true })

vim.cmd([[
" close all buffers except current one
command! BufCurOnly execute '%bdelete|edit#|bdelete#'
]])
remap('n', '<leader>bd', ':BufCurOnly<CR>', { noremap = true, silent = true })

-- KEEPING IT CENTERED
remap('n', 'n', 'nzz', { noremap = true, silent = true })
remap('n', 'N', 'Nzz', { noremap = true, silent = true })
remap('n', 'J', "mzJ'z", { noremap = true, silent = true })

-- ETC
remap('n', '<leader>nh', ':nohlsearch<CR>', { noremap = true, silent = true })
remap('n', 'ci,', ':call DeleteInnerArg()<CR>', { noremap = true, silent = true })
remap({ 'n', 'i', 'v', 'c' }, '<c-q>', '<esc>', { noremap = true, silent = true })
-- remap('v', 's', ':lua InsertTextWithBrace()<CR>', { noremap = true, silent = true })

remap('n', 'Y', 'y$', { noremap = true, silent = true })

-- PASTE IN VISUAL MODE WITHOUT LOSING ORIGINAL CLIPBOARD
-- "_d is to enroll the selected visual region into the '_' register deleting
-- the region. As a result, the unnamed register '"', which is default register
-- we generally use, does not be removed.
remap('x', "<leader>p", "\"_dP", { noremap = true, silent = true })

-- PARMANENT HIGHLIGHTING ON ONE LINE
-- define line highlight color. this can be written in vimL like
-- "highlight LineHighlight ctermbg=gray guibg=gray"
-- local ns_id = vim.api.nvim_create_namespace('my_namespace')
-- vim.api.nvim_set_hl(0, 'LineHighlight', { ctermbg = 'gray', guibg = 'gray' })
-- vim.api.nvim_set_hl(0, 'LineHighlight', { ctermbg = 'gray' })
-- highlight the current line
remap("n", '<Leader>L', ":call matchadd('TermCursor', '\\%'.line('.').'l')<CR>", { noremap = true, silent = true })
-- remap("n", '<Leader>L', ":call matchadd('TermCursor', '\\%3l')<CR>", { noremap = true, silent = true })
-- clear all the highlighted lines
remap("n", '<Leader>C', ":call clearmatches()<CR>", { noremap = true, silent = true })
