require('avante').setup({
  provider = "openai",
  providers = {
    openai = {
      -- endpoint = "https://api.openai.com/v1",
      model = "gpt-4o-mini", -- your desired model (or use gpt-4o, etc.)
      -- model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
      -- extra_request_body = {
      --   timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
      --   temperature = 0.75,
      --   max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
    },
  },
  disabled_tools = { "run_python", "git_diff", "git_commit" },
  behaviour = {
    auto_suggestions = false, -- Experimental stage
    auto_set_highlight_group = true,
    auto_set_keymaps = true,
    auto_apply_diff_after_generation = false,
    support_paste_from_clipboard = false,
    minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
    enable_token_counting = true, -- Whether to enable token counting. Default to true.
    auto_approve_tool_permissions = false, -- Default: show permission prompts for all tools
    -- Examples:
    -- auto_approve_tool_permissions = true,                -- Auto-approve all tools (no prompts)
    -- auto_approve_tool_permissions = {"bash", "replace_in_file"}, -- Auto-approve specific tools only
  },
})
