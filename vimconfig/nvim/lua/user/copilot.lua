-- local isOllamaRunning = require("plenary.curl").get("http://localhost:11434", {
--   timeout = 50,
--   on_error = function(e) return { status = e.exit } end,
-- }).status == 200
--
-- There are some issues in using copilot.
-- First, somtimes the llm_ls exits without error for some unknown reasons.
-- Second, I can't control prompt

local llm = require('llm')

llm.setup({
  apiToken = nil,
  model = "codellama",
  url = "http://localhost:11434/api/generate",
  backend = 'ollama',
  request_body = {
    options = {
      temperature = 0.2,
      top_p = 0.95,
    }
  },
  tokens_to_clear = { "<EOT>" },
  fim = {
    enabled = true,
    prefix = "<PRE> ",
    middle = " <MID>",
    suffix = " <SUF>",
  },
  context_window = 4096,
  tokenizer = {
    repository = "codellama/CodeLlama-13b-hf",
  },
  enable_suggestions_on_startup = false,
})

