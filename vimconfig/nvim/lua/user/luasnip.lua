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
  local open = function(path)
    local cmd = 'tabnew ' .. path
    vim.api.nvim_command(cmd)
  end

  local filetype = vim.bo.filetype
  local path_root = ' ~/.config/nvim/my-snippets/snippets/'
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
  elseif filetype == 'lua' then
    -- print('this is latex')
    local path = path_root .. 'lua.json'
    open(path)
  elseif filetype == 'json' then
    -- print('this is latex')
    local path = path_root .. 'json.json'
    open(path)
  elseif filetype == 'javascript' then
    -- print('this is latex')
    local path = path_root .. 'javascript.json'
    open(path)
  end

  -- ENABLE TO EXIT USING 'Q' KEY
  vim.api.nvim_buf_set_keymap(0, "n", "q", ":bwipe<CR>", {})
  vim.api.nvim_buf_attach(0, true, {
    on_detach = function(...)
      RefreshSnippet()
    end,
  })
end

-- command! Os lua OpenSnippet() 
vim.api.nvim_create_user_command("Os", OpenSnippet, {})
