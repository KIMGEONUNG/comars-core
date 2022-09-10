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
