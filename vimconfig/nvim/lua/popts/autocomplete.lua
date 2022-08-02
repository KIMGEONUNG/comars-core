vim.opt.completeopt='menu,menuone,noselect'

local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - YOU MUST SPECIFY A SNIPPET ENGINE
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },

  window = {
    -- THIS IS AWESOME VISUAL INTERFACE, BUT INVOKE AN INCONVENIENT LATENCY.
    documentation = cmp.config.window.bordered(),
    completion = cmp.config.window.bordered(),
  },

  -- WARNING: IF YOU USE SIMPLE CURLY BRACKET SUCH AS "mapping = {}",
  -- SOME ESSENTIAL SHORTCUT OVERRIDING MIGHT BE OMITTED.
  -- FOR EXAMPLE, "CTNL-N" KEY WOULD WORK FOR NVIM NATIVE AUTOCOMPLETE, NOT FOR
  -- LSP AUTOCOMPLETE
  mapping = cmp.mapping.preset.insert({
    -- ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
    -- ['<C-n>'] = cmp.mapping.complete(),
    -- ['<C-e>'] = cmp.mapping.abort(),
    -- ACCEPT CURRENTLY SELECTED ITEM. SET `SELECT` TO `FALSE` TO ONLY
    -- CONFIRM EXPLICITLY SELECTED ITEMS.
    -- ['<leader>'] = cmp.mapping.confirm({ select = true }),
    -- ['<Tab>'] = cmp.mapping.complete(),
    -- ['<Tab>'] = require'luasnip'.expand_or_jump()
    -- --
    ["<Tab>"] = cmp.mapping(function(fallback)
      require'luasnip'.expand_or_jump()
    end, { "i", "s" }),
  }),

  sources = cmp.config.sources({
    { name = 'luasnip' }, -- FOR LUASNIP USERS
    -- { name = 'luasnip', option = { use_show_condition = false } }, -- FOR LUASNIP USERS
    { name = 'nvim_lua' },
    { name = 'nvim_lsp' },
    -- { name = 'nvim_lsp', max_item_count = 5 },
    { name = 'path' },
    { name = 'buffer', keyword_lenght = 5 },
  }),

  experimental = {
    native_menu = false,
    ghost_text = true,
  },
})

-- Set configuration for specific filetype.
-- cmp.setup.filetype('gitcommit', {
--   sources = cmp.config.sources({
--     { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
--   }, {
--     { name = 'buffer' },
--   })
-- })

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline('/', {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = {
--     { name = 'buffer' }
--   }
-- })

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
