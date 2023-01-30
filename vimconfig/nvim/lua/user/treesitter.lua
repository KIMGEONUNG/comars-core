local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup {
  ensure_installed = { "c", "lua", "vim", "help" },
  sync_install = false,
  auto_install = true,
  ignore_install = { "javascript" },
  -- highlight = {
  --   enable = true,
  --   disable = {},
  --   additional_vim_regex_highlighting = false,
  -- },
}
