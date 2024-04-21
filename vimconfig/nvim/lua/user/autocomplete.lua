vim.opt.completeopt = 'menu,menuone,noselect'

-- DEFINE COLORS
-- vim.api.nvim_set_hl(0, "MyPmenu", { bg = "Black", fg = "White" })
vim.api.nvim_set_hl(0, "MyPmenuSel", { bg = "White", fg = "Black", bold = true, italic = true })
--
vim.api.nvim_set_hl(0, "CmpItemAbbr", { bg = "None", fg = "#aaafff" })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { bg = "None", fg = "#fdff00" })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { bg = "None", fg = "#ec5300" })

local border_config = {
  border = "double",
  -- winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuThumb,Search:Error",
  winhighlight = "Normal:MyPmenu,FloatBorder:MyPmenu,CursorLine:MyPmenuSel,Search:None",
}

local cmp = require 'cmp'
local luasnip = require 'luasnip'


cmp.setup({
  snippet = {
    -- REQUIRED - YOU MUST SPECIFY A SNIPPET ENGINE
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  window = {
    -- THIS IS AWESOME VISUAL INTERFACE, BUT INVOKE AN INCONVENIENT LATENCY.
    documentation = cmp.config.window.bordered(border_config),
    completion = cmp.config.window.bordered(border_config),
    -- completion = cmp.config.window.bordered({ border = {"◆", "━", "■", "┃", "■", "━", "■", "┃"}}),
  },

  formatting = {},

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

    -- ['<C-x><C-o>'] = cmp.mapping.complete(),

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

  view = {
    -- entries = "native",
    -- entries = "wildmenu",
    entries = "custom",
  },

  experimental = {
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
