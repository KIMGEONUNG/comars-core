
-- OFF THE UNDERLINE WHEN WARNING OR ERROR EXIT
vim.lsp.handlers["textDocument/publishDiagnostics"] =
      vim.lsp.with(
          vim.lsp.diagnostic.on_publish_diagnostics,
          { underline = false }
      )

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, bufopts)

  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)

  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<c-f>', vim.lsp.buf.formatting, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)

  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)

  -- UNKNOWN USAGES BELOWS
  -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)

  -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  -- vim.keymap.set('n', '<space>wl', function()
  --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  -- end, bufopts)
  --
  -- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  -- vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
end

-- UNKNOWN
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- capabilities.textDocument.completion.completionItem.snippetSupport = true

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

require('lspconfig').pylsp.setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    settings = {
      pylsp = {
        -- configurationSources = {"flake8"},
        plugins = {
          autopep8 = {
            enabled = false,
          },
          yapf = {
            enabled = true,
          },

          flake8 = {
            indentSize = 2,
          }
        }
      }
    }
}
-- pylsp.plugins.flake8.indentSize


require'lspconfig'.clangd.setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}

require'lspconfig'.sumneko_lua.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}
require'lspconfig'.bashls.setup{}
