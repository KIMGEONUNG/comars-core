
-- # NVIM-LSPCONFIG========================================================
-- Off the underline which occurs when warning or error exit
vim.lsp.handlers["textDocument/publishDiagnostics"] =
      vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics,
      {
        underline = false 
      }
    )

vim.cmd([[
    nnoremap <silent> gD :lua vim.lsp.buf.declaration()<CR>zz
    nnoremap <silent> gd :lua vim.lsp.buf.definition()<CR>zz
    nnoremap <silent> gr :lua vim.lsp.buf.references()<CR>
    nnoremap <silent> K :lua vim.lsp.buf.hover()<CR>
    nnoremap <silent> gi :lua vim.lsp.buf.implementation()<CR>
    nnoremap <silent> <c-f> :call Format(expand('%:t'))<CR>
    nnoremap <silent> <leader>rn :lua vim.lsp.buf.rename()<CR>
]])

require'lspconfig'.pyls.setup{on_attach=require'completion'.on_attach}
require'lspconfig'.vimls.setup{on_attach=require'completion'.on_attach}
require'lspconfig'.hls.setup{on_attach=require'completion'.on_attach}
require'lspconfig'.jsonls.setup{cmd={"vscode-json-languageserver", "--stdio"}}
require'lspconfig'.bashls.setup{on_attach=require'completion'.on_attach}
require'lspconfig'.clangd.setup{on_attach=require'completion'.on_attach}


--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.html.setup{on_attach=require'completion'.on_attach, 
capabilities = capabilities,
cmd={ "vscode-html-language-server", "--stdio" },
init_options={
      configurationSection = { "html", "css", "javascript" },
      embeddedLanguages = {
        css = true,
        javascript = true
      },
      provideFormatter = true
    }
}


vim.cmd([[

" nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
" nnoremap <silent> <space>wa <cmd>lua vim.lsp.buf.add_workspace_folder()<CR>
" nnoremap <silent> <space>wr <cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>
" nnoremap <silent> <space>wl <cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>
" nnoremap <silent> <space>D <cmd>lua vim.lsp.buf.type_definition()<CR>
" nnoremap <silent> <space>ca <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> [e <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap <silent> [d <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> ]d <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
" nnoremap <silent> <space>q <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
]])

vim.cmd([[
" # COMPLETION-NVIM=======================================================
set completeopt=menuone,noinsert,noselect
set shortmess+=c
" let g:completion_enable_snippet = 'UltiSnips'
let g:completion_enable_auto_popup = 1
imap <silent> <c-n> <Plug>(completion_trigger)

]])


vim.g.completion_chain_complete_list = {
         default = {
             default= {
                 {complete_items= { 'lsp', 'snippet' }},
             {mode= '<c-p>'},
             {mode= '<c-n>'} },
           comment= {},
           string = { {complete_items= { 'path' }} }
           } }

vim.cmd([[
" # NEO-SNIPS=============================================================
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

if has('conceal')
  set conceallevel=0 
endif 

]])

