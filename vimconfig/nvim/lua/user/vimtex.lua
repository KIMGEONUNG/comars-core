Vimtex = {}

-- SHORCUTS
-- Press \ll to start (or stop) compiling the document.
-- Press \lk to stop the compilation process
-- Press \lc to clear auxiliary files.
-- Press \lv to forward search. This will open the compiled PDF.
-- Press \le also closes the QuickFix menu when it is open.
-- Press \lt to show a window with a table of contents for your document.


-- This is necessary for VimTeX to load properly. The "indent" is optional.
-- Note that most plugin managers will do this automatically.
vim.cmd([[ filetype plugin indent on ]])

-- Viewer options: One may configure the viewer either by specifying a built-in
vim.g.vimtex_view_method = 'zathura'

-- This enables Vim's and neovim's syntax-related features. Without this, some
-- VimTeX features will not work (see ":help vimtex-requirements" for more info).
vim.cmd([[ syntax enable ]])

-- Or with a generic interface:
vim.g.vimtex_view_general_viewer = 'okular'
vim.g.vimtex_view_general_options = '--unique file:@pdf\\#src:@line@tex'
vim.g.vimtex_quickfix_enabled = true

-- VimTeX uses latexmk as the default compiler backend. If you use it, which is
-- strongly recommended, you probably don't need to configure anything. If you
-- want another compiler backend, you can change it as follows. The list of
-- supported backends and further explanation is provided in the documentation,
-- see ":help vimtex-compiler".
-- let g:vimtex_compiler_method = 'latexrun'
--
-- Most VimTeX mappings rely on localleader and this can be changed with the
-- following line. The default is usually fine and is the symbol "\".
-- let maplocalleader = ","
--
vim.cmd([[
let g:vimtex_quickfix_ignore_filters = [
      \ 'LaTeX Warning: No positions in optional float specifier.',
      \ 'Overfull',
      \]
]])

function Vimtex.AddExp()
  -- DEFINE ID
  local id = vim.fn.input('ID: ')
  if id == "" then
     print("Exit with ESC or empty string")
     return
  end
  -- local id = vim.fn.expand('%:r')

  -- ADD NEW DIRECTORY FOR ASSETS
  local cmd = 'mkdir -p assets/' .. id
  local a = os.execute(cmd)
  if a ~= 0 then
    print("Fail")
    return
  end

  -- ADD FILE
  local cmd = 'touch ' .. id .. '.tex'
  local a = os.execute(cmd)
  if a ~= 0 then
    print("Fail")
    return
  end

  -- OPEN THE FILE
  vim.api.nvim_command('e ' .. id .. '.tex')

  -- ADD FILE AND BUFFER
  local lines = {
    "\\clearpage",
    "\\subsection{" .. id .. "}",
    "% \\label{subsec:" .. id .. "}",
    "",
    "\\begin{itemize} ",
    "  \\item",
    "\\end{itemize} ",
    "",
    -- "\\subsubsection{} ",
    -- "",
    -- "\\begin{equation}",
    -- "  \\begin{aligned}",
    -- "  \\end{aligned}",
    -- "  % \\label{eq:" .. id .. "}",
    -- "\\end{equation}",
    -- "",
    -- "\\begin{algorithm}",
    -- "\\caption{Unknown}",
    -- "% \\label{algo:" .. id .. "}",
    -- "\\end{algorithm}",
    -- "",
    -- "\\begin{figure}[ht]",
    -- "  \\begin{center}",
    -- "    \\includegraphics[width=0.95\\textwidth]{assets/" .. id .. "/autofig.pdf}",
    -- "  \\end{center}",
    -- "  \\caption{Unknown}",
    -- "  % \\label{fig:" .. id .. "}",
    -- "\\end{figure}",
    -- "",
    -- "\\subsubsection{Conclusions} ",
    "",
    "\\clearpage",
  }
  local buf = vim.api.nvim_get_current_buf() -- Get the current buffer
  -- Add lines at the end of the buffer
  vim.api.nvim_buf_set_lines(buf, 0, 0, false, lines)
end

function Vimtex.CustomKeymap()
  vim.api.nvim_buf_set_keymap(0, 'n', '\\ln', ':lua Vimtex.AddExp()<CR>', { noremap = true, silent = true })
end

local group = vim.api.nvim_create_augroup("VimtexCustom", {})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "tex",
  command = "lua Vimtex.CustomKeymap()",
  group = group
})
