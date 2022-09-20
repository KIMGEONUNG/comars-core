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

-- LOAD SNIPPETS
local function load_snippets()
  require("luasnip.loaders.from_vscode").lazy_load()
  require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./my-snippets" } })
end
load_snippets()

-- RELOAD SNIPPETS
function RefreshSnippet()
  require("luasnip").cleanup()
  load_snippets()
end

-- FOR FAST SNIPPET EDITING
function OpenSnippet()
  -- print('dkdk', 'dkd')
  local open = function (path)
    local cmd = 'edit ' .. path
    vim.api.nvim_command('split')
    vim.api.nvim_command(cmd)
  end

  local filetype = vim.bo.filetype
  local path_root =' ~/.config/nvim/my-snippets/snippets/'
  if filetype == 'python' then
    -- print('this is python')
    local path = path_root .. 'python.json'
    open(path)
  elseif filetype == 'tex' then
    -- print('this is latex')
    local path = path_root .. 'tex.json'
    open(path)
  elseif filetype == 'sh' then
    -- print('this is latex')
    local path = path_root .. 'shell.json'
    open(path)
  end
end

vim.cmd([[
command! OpenSnip lua OpenSnippet() 
command! ReSnip lua RefreshSnippet() 
]])
