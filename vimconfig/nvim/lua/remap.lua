-- MAPS -----------------------------------------------------------------------

vim.cmd([[
map <SPACE> <Nop>
let g:mapleader="\<Space>"

nnoremap <c-o> <c-o>zz
nnoremap <c-i> <c-i>zz

nnoremap ci, :call DeleteInnerArg()<CR>

nmap <Leader>D :call DeleteChar()<CR>
nmap <Leader>x :call DeleteTo()<CR>

" nnoremap <s-f> #*

nmap <Leader>e :call ExecuteFile(expand('%:t'))<CR>
nmap <Leader>E :call ExecutePredef()<CR>
nmap <Leader>w :w<CR> 
nmap <Leader>q :q<CR> 

nnoremap <Leader>gs ^
nnoremap <Leader>ge $

nnoremap <Leader>bn :bn<CR>
nnoremap <Leader>bp :bp<CR>
nnoremap <Leader>bw :bw<CR>
" close all buffers except current one
command! BufCurOnly execute '%bd|e#'
nnoremap <Leader>bd :BufCurOnly<CR>

nnoremap <Leader>nh :noh<CR>

nnoremap <Leader>h :wincmd h<CR>
nnoremap <Leader>j :wincmd j<CR>
nnoremap <Leader>k :wincmd k<CR>
nnoremap <Leader>l :wincmd l<CR>
" nnoremap <Leader>x :wincmd x<CR>

nnoremap <Leader>0 :resize +10<CR>
nnoremap <Leader>9 :resize -10<CR>
nnoremap <Leader>= :vertical resize +10<CR>
nnoremap <Leader>- :vertical resize -10<CR>

nnoremap <C-u> 10kzz 
nnoremap <C-d> 10jzz 
vnoremap <C-u> 10kzz 
vnoremap <C-d> 10jzz 

inoremap <C-q> <ESC>
nnoremap <C-q> <ESC>
vnoremap <C-q> <ESC>
cnoremap <C-q> <ESC>

" nnoremap <C-a> ^
nnoremap <C-e> <ESC>$
nnoremap <C-f> W
nnoremap <C-b> B

" vnoremap <C-a> ^
vnoremap <C-e> $h

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

inoremap <C-@> <C-x><C-o>

" inoremap <C-a> <C-o>^
inoremap <C-e> <C-o>$
inoremap <C-f> <C-o>W
inoremap <C-b> <C-o>B
inoremap <C-l> <C-o>l

" inoremap <C-d> <C-o>diw
" inoremap <C-d> <esc>:call DeleteBackward()<cr>a
" inoremap <C-d> <BS>
" inoremap <expr> <C-d> DeleteBackward()
inoremap <C-d> <c-o>:call DeleteBackward()<cr>

" Keeping it centered
nnoremap n nzz
nnoremap N Nzz
nnoremap J mzJ'z

nnoremap Y y$

" Undo break points
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

" Jumplist mutation
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

nnoremap <C-j> :cnext<CR>
nnoremap <C-k> :cprevious<CR>
]])

