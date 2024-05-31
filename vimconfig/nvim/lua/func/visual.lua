local function getVisualSelectionRange()
  -- Get the start and end positions of the visual selection
  local start_pos = vim.fn.getpos("v")
  local end_pos = vim.fn.getpos(".")
  local start_line = start_pos[2]
  local end_line = end_pos[2]
  local diff = end_line - start_line
  return diff
end

local function visualSelectRange(start_pos, end_pos)
  local diff = end_pos - start_pos

  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("0", true, false, true), 'n', true)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(tostring(start_pos - 1) .. "l", true, false, true), 'n', true)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("v", true, false, true), 'n', true)

  if diff ~= 0 then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(tostring(end_pos - start_pos) .. "l", true, false, true), 'n',
      true)
  end

end

local function selectVisualWhole()
  -- ON work in line visual mode
  if vim.api.nvim_get_mode().mode ~= 'V' then
    return
  end

  if getVisualSelectionRange() ~= 0 then
    return
  end

  local current_line = vim.api.nvim_win_get_cursor(0)[1]
  local current_line_content = vim.api.nvim_get_current_line()
  local last_char_pos = #current_line_content
  local esc_key = vim.api.nvim_replace_termcodes("<Esc>", true, true, true)

  -- Find the position of the first non-empty character
  local first_non_empty_pos = nil
  for i = 1, #current_line_content do
    if current_line_content:sub(i, i) ~= ' ' and current_line_content:sub(i, i) ~= '\t' then
      first_non_empty_pos = i
      break
    end
  end

  vim.api.nvim_feedkeys(esc_key, 'n', false)
  visualSelectRange(first_non_empty_pos, last_char_pos)
end

local function selectVisualLefthandb()
  -- ON work in line visual mode
  if vim.api.nvim_get_mode().mode ~= 'V' then
    return
  end

  if getVisualSelectionRange() ~= 0 then
    return
  end


  local current_line_content = vim.api.nvim_get_current_line()

  local first_non_empty_pos = nil
  for i = 1, #current_line_content do
    if current_line_content:sub(i, i) ~= ' ' and current_line_content:sub(i, i) ~= '\t' then
      first_non_empty_pos = i
      break
    end
  end

  local first_eq_pos = nil
  for i = 1, #current_line_content do
    if current_line_content:sub(i, i) == '=' then
      first_eq_pos = i
      break
    end
  end

  if first_eq_pos == nil then
    return
  end

  local esc_key = vim.api.nvim_replace_termcodes("<Esc>", true, true, true)
  vim.api.nvim_feedkeys(esc_key, 'n', false)
  visualSelectRange(first_non_empty_pos, first_eq_pos - 1)
end

local function selectVisualRighthand()
  -- ON work in line visual mode
  if vim.api.nvim_get_mode().mode ~= 'V' then
    return
  end

  if getVisualSelectionRange() ~= 0 then
    return
  end

  local current_line_content = vim.api.nvim_get_current_line()
  local last_char_pos = #current_line_content

  local first_eq_pos = nil
  for i = 1, #current_line_content do
    if current_line_content:sub(i, i) == '=' then
      first_eq_pos = i
      break
    end
  end

  if first_eq_pos == nil then
    return
  end

  local esc_key = vim.api.nvim_replace_termcodes("<Esc>", true, true, true)
  vim.api.nvim_feedkeys(esc_key, 'n', false)
  visualSelectRange(first_eq_pos + 1, last_char_pos)
end

vim.keymap.set('v', 'H', function() selectVisualWhole() end, { noremap = true })
vim.keymap.set('v', 'L', function() selectVisualLefthandb() end, { noremap = true })
vim.keymap.set('v', 'R', function() selectVisualRighthand() end, { noremap = true })
