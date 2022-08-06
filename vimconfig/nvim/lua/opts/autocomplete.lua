vim.opt.completeopt='menu,menuone,noselect'

local cmp = require'cmp'
local luasnip = require'luasnip'

cmp.setup({
  snippet = {
    -- REQUIRED - YOU MUST SPECIFY A SNIPPET ENGINE
    expand = function(args)
      luasnip.lsp_expand(args.body)
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
    -- --
    ["<c-k>"] = cmp.mapping(function()
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { "i", "s" }),
    
    ["<c-j>"] = cmp.mapping(function()
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { "i", "s" }),

  }),

  sources = cmp.config.sources({
    { name = 'nvim_lua' },

    { name = 'nvim_lsp' },
    { name = 'luasnip' }, -- FOR LUASNIP USERS
    -- { name = 'nvim_lsp', max_item_count = 5 },
    { name = 'path' },
    -- { name = 'buffer', keyword_lenght = 5 },
  }),

  experimental = {
    native_menu = false,
    ghost_text = true,
  },
})

-- USE CMDLINE & PATH SOURCE FOR ':'
-- IF YOU ENABLED `NATIVE_MENU`, THIS WON'T WORK ANYMORE.
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})


require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").load({ paths = { "./my-snippets" } })
