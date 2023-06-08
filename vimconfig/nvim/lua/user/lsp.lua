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
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, bufopts)

  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)

  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<c-f>', vim.lsp.buf.formatting, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)

  -- SHOW ME THE DOCUMENTATION
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
end

-- UNKNOWN
-- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

-- PYTHON
require('lspconfig').pylsp.setup {
  on_attach = on_attach,
  flags = lsp_flags,
  -- capabilities = capabilities,
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
        --
        -- flake8 = {
        --   indentSize = 2,
        -- }
      }
    }
  }
}
-- pylsp.plugins.flake8.indentSize

-- CPP
require 'lspconfig'.clangd.setup {
  on_attach = on_attach,
  flags = lsp_flags,
  -- capabilities = capabilities,
}

-- JAVASCRIPT
require 'lspconfig'.tsserver.setup {
  on_attach = on_attach,
  flags = lsp_flags,
  -- capabilities = capabilities,
  cmd = { "typescript-language-server", "--stdio" },
  -- settings = {
  -- }
}

-- JSON
require 'lspconfig'.jsonls.setup {
  on_attach = on_attach,
  flags = lsp_flags,
  -- capabilities = capabilities,
  cmd = { "vscode-json-language-server", "--stdio" },
  -- settings = {
  -- }
}

-- HTML
require 'lspconfig'.html.setup {
  on_attach = on_attach,
  flags = lsp_flags,
  -- capabilities = capabilities,
  cmd = { "vscode-html-language-server", "--stdio" },
  init_options = {
    configurationSection = { "html", "css", },
    embeddedLanguages = {
      css = true,
      -- javascript = true,
    },
  },
  -- settings = {
  -- }
}

-- -- CSS
require 'lspconfig'.cssls.setup {
  on_attach = on_attach,
  flags = lsp_flags,
  -- capabilities = capabilities,
  cmd = { "vscode-css-language-server", "--stdio" },
  -- settings = {
  -- }
}

-- LUA
-- require 'lspconfig'.sumneko_lua.setup {
--   on_attach = on_attach,
--   flags = lsp_flags,
--   -- capabilities = capabilities,
--   settings = {
--     Lua = {
--       runtime = {
--         -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
--         version = 'LuaJIT',
--         -- Setup your lua path
--         path = vim.split(package.path, ';'),
--       },
--       diagnostics = {
--         -- Get the language server to recognize the `vim` global
--         globals = { 'vim' },
--       },
--       workspace = {
--         -- Make the server aware of Neovim runtime files
--         library = {
--           [vim.fn.expand('$VIMRUNTIME/lua')] = true,
--           [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
--         },
--       },
--     },
--   }
-- }
require 'lspconfig'.bashls.setup {}
