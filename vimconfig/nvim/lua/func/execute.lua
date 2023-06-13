-- INIT
vim.g.is_logging = false
vim.g.auto_open = true
local path_log = "log.txt"
local lang_exe_pairs = {
  python = "python",
  lua = "lua",
  sh = "bash",
  cpp = "cpp",
}
-- when call verticalsplit(vs), a new window open at the right side
vim.opt.splitright = true
vim.opt.splitbelow = true

-- ON-OFF CONFIGURATION
function SetLog(arg)
  vim.g.is_logging = arg
end

vim.api.nvim_create_user_command("LogOn", 'lua SetLog(true)', {})
vim.api.nvim_create_user_command("LogOff", 'lua SetLog(false)', {})

function SetAutoOpen(arg)
  vim.g.auto_open = arg
end

vim.api.nvim_create_user_command("AuoOn", 'lua SetAutoOpen(true)', {})
vim.api.nvim_create_user_command("AuoOff", 'lua SetAutoOpen(false)', {})


-- CALLBACKS
local _on_stdout4log = function(_, data, _)
  -- GET LOG BUFFER ID
  local id_buf = vim.fn.bufnr(path_log)
  -- CLEAR LOG BUFFER
  vim.api.nvim_buf_set_lines(id_buf, 0, -1, false, {})

  -- Write stdout to log file
  if data then
    -- print(require("inspect")(data))
    vim.api.nvim_buf_set_lines(id_buf, -1, -1, false,
      { "===== STDOUT =====" })
    vim.api.nvim_buf_set_lines(id_buf, -1, -1, false, data)
  end
end

local _on_stderr4log = function(_, data, _)
  -- Get buffer id
  local id_buf = vim.fn.bufnr(path_log)
  -- Write stdout to log file
  if data then
    vim.api.nvim_buf_set_lines(id_buf, -1, -1, false,
      { "===== STDERR =====" })
    vim.api.nvim_buf_set_lines(id_buf, -1, -1, false, data)
  end
end

function ExecuteFile()
  -- INIT
  vim.api.nvim_command('write')
  local path_file = vim.fn.expand("%:p")
  local filetype = vim.bo.filetype

  -- VERY SPECIFIC EXECUTION
  if vim.fn.expand("%") == "autofig.yaml" then
    vim.fn.jobstart("autofig")
    return
  end

  -- FIND EXECUTION PROGRAM
  local exe = lang_exe_pairs[filetype]

  -- IF SHEBANG EXIST, OVERRIDE THE EXECUTION
  local line = vim.fn.getline(1)
  if string.sub(line, 1, 2) == "#!" then
    exe = string.sub(line, 3, -1)
  end

  -- CHECK FILETYPE AND EXECUTE ACCORDING TO TYPE
  if exe == nil then
    print("Undifined execution")
    return
  elseif exe == "cpp" then
    local target = 'doit.sh'
    if vim.fn.filereadable(target) then
      vim.api.nvim_command("!bash doit.sh")
    else
      print("No target file:" .. target)
    end
    return
  end

  if vim.g.is_logging then
    -- OPEN LOG BUFFER
    vim.api.nvim_command("badd " .. path_log)

    -- IF AUTO_OPEN, ADD NEW WINDOW FOR THAT LOG BUFFER
    if vim.g.auto_open then
      local b_info = vim.fn.getbufinfo(path_log)
      local is_hidden = b_info[1].hidden == 1
      local is_unload = b_info[1].loaded == 0
      -- CLEAR LOG BUFFER
      vim.api.nvim_buf_set_lines(vim.fn.bufnr(path_log), 0, -1, false, {})
      if is_hidden or is_unload then
        vim.api.nvim_command("vs " .. path_log)
        vim.api.nvim_command("wincmd p")
      end
    end

    -- START PROGRAM
    if vim.g.auto_open then
      vim.fn.jobstart(exe .. " " .. path_file, {
        stdout_buffered = true,
        stderr_buffered = true,
        on_stdout = _on_stdout4log,
        on_stderr = _on_stderr4log,
        on_exit = function()
          vim.api.nvim_command("wall")
        end
      })
    end
  else
    vim.api.nvim_command("!" .. exe .. " %")
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
