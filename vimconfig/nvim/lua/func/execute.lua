-- local inspect = require('inspect')
vim.g.is_logging = false
local path_log = "log.txt"

function SetLog(arg)
  vim.g.is_logging = arg
end

vim.api.nvim_create_user_command("LogOn", 'lua SetLog(true)', {})
vim.api.nvim_create_user_command("LogOff", 'lua SetLog(false)', {})

local _on_stdout4log = function(_, data, _)
  -- Open hidden buffer returning bufnr
  vim.api.nvim_command("badd " .. path_log)
  -- Get log buffer id
  local id_buf = vim.fn.bufnr(path_log)
  -- Clear log buffer
  vim.api.nvim_buf_set_lines(id_buf, 0, -1, false, {})

  -- Write stdout to log file
  if data then
    vim.api.nvim_buf_set_lines(id_buf, -1, -1, false,
      { "===== STDOUT =====" })
    vim.api.nvim_buf_set_lines(id_buf, -1, -1, false, data)
    vim.api.nvim_command("wall")
  end
end

local _on_stderr4log = function(_, data, _)
  -- Open hidden buffer returning bufnr
  vim.api.nvim_command("badd " .. path_log)

  -- Get buffer id
  local id_buf = vim.fn.bufnr(path_log)

  -- Write stdout to log file
  if data then
    vim.api.nvim_buf_set_lines(id_buf, -1, -1, false,
      { "===== STDERR =====" })
    vim.api.nvim_buf_set_lines(id_buf, -1, -1, false, data)
    vim.api.nvim_command("wall")
  end
end

function ExecuteFile()

  vim.api.nvim_command('write')
  local path_file = vim.fn.expand("%:t")

  -- IF SHEBANG EXIST, FOLLOW THAT
  local line = vim.fn.getline(1)
  if string.sub(line, 1, 2) == "#!" then
    local cmd = string.sub(line, 3, -1)
    cmd = "!" .. cmd .. " %"
    vim.api.nvim_command(cmd)
    return
  end

  -- CHECK FILETYPE AND EXECUTE ACCORDING TO TYPE
  if vim.bo.filetype == "python" then
    if vim.g.is_logging then
      vim.fn.jobstart({ "python", path_file }, {
        stdout_buffered = true,
        on_stdout = _on_stdout4log,
        on_stderr = _on_stderr4log
      })
    else
      vim.api.nvim_command("!python %")
    end
  elseif vim.bo.filetype == "lua" then
    if vim.g.is_logging then
      vim.fn.jobstart({ "lua", path_file }, {
        stdout_buffered = true,
        on_stdout = _on_stdout4log,
        on_stderr = _on_stderr4log
      })
    else
      vim.api.nvim_command("!lua %")
    end
  elseif vim.bo.filetype == "sh" then
    if vim.g.is_logging then
      vim.fn.jobstart({ "bash", path_file }, {
        stdout_buffered = true,
        on_stdout = _on_stdout4log,
        on_stderr = _on_stderr4log
      })
    else
      vim.api.nvim_command("!bash %")
    end
  end

  -- elseif !empty(matchstr(arg, '.html$')) then
  --   vim.api.nvim_command("!google-chrome %")
  -- elseif !empty(matchstr(arg, '.js$')) then
  --   vim.api.nvim_command("!google-chrome index.html")
  -- elseif !empty(matchstr(arg, '.css$')) then
  --   vim.api.nvim_command("!google-chrome index.html")
  -- elseif !empty(matchstr(arg, '.cpp$')) or !empty(matchstr(arg, '.h$')) then
  --   local target = 'doit.sh'
  --   if filereadable(target) then
  --     vim.api.nvim_command("!bash doit.sh")
  --   else
  --     print("No target file:" .. target)
  --   end
  -- elseif !empty(matchstr(arg, '.vim$')) then
  --   vim.api.nvim_command("so % ")
  -- end
end
