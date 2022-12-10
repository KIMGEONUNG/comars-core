vim.g.path_vclip = os.getenv("HOME") .. "/.cache/vimclipboard.txt"

function copy2vimclip()
  local file = io.open(vim.g.path_vclip, "w")
  local from = vim.fn.getpos("'<")[2]
  local to = vim.fn.getpos("'>")[2]

  for i = from, to do
    local content = vim.fn.getline(i) .. "\n"
    file:write(content)
  end
  file:close()
end

function paste3vimclip()
  local file = io.open(vim.g.path_vclip, "r")
  local content = file:read("*all")
  local lines = {}
  for s in content:gmatch("[^\r\n]+") do
      table.insert(lines, s)
  end
  table.insert(lines, "")

  local num_buf = vim.fn.bufnr("%")
  local num_line = vim.fn.line(".")

  vim.api.nvim_buf_set_text(num_buf, num_line, 0, num_line, 0, lines)
end

vim.api.nvim_create_user_command("VCopy", 'lua copy2vimclip()', {}) 
vim.api.nvim_create_user_command("VPaste", 'lua paste3vimclip()', {}) 
