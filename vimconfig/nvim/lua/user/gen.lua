local M = require('gen')
M.setup({
  -- model = "codellama",
  model = "mistral", -- The default model to use.
  -- host = "localhost", -- The host running the Ollama service.
  -- port = "11434", -- The port on which the Ollama service is listening.
  -- quit_map = "q", -- set keymap for close the response window
  -- retry_map = "<c-r>", -- set keymap to re-send the current prompt
  -- init = function(options) pcall(io.popen, "ollama serve > /dev/null 2>&1 &") end,
  -- -- Function to initialize Ollama
  -- command = function(options)
  --   local body = { model = options.model, stream = true }
  --   return "curl --silent --no-buffer -X POST http://" .. options.host .. ":" .. options.port .. "/api/chat -d $body"
  -- end,
  -- -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
  -- -- This can also be a command string.
  -- -- The executed command must return a JSON object with { response, context }
  -- -- (context property is optional).
  -- -- list_models = '<omitted lua function>', -- Retrieves a list of model names
  display_mode = "float", -- The display mode. Can be "float" or "split".
  show_prompt = true, -- Shows the prompt submitted to Ollama.
  show_model = true, -- Displays which model you are using at the beginning of your chat session.
  no_auto_close = true, -- Never closes the window automatically.
  -- debug = false -- Prints errors and the command which is run.
})

vim.keymap.set({ 'n', 'v' }, '<leader>]', ':Gen<CR>')

-- Custom table
local prompts = require('gen.prompts')
prompts["Make_Table_Latex"] = {
  prompt = "Render the following text as a latex table:\n$text",
  replace = true,
}
  
require('gen').prompts['Gen'] = {
  -- prompt = "Generate $filetype code with only ouput results in format ```$filetype\n...\n``` as following: $input.",
  prompt = "Generate $filetype code regarding the description: $input,\n Please, only output the result in format ```$filetype\n...\n```",
  replace = true,
  extract = "```$filetype\n(.-)```"
  -- extract = "```$filetype\n(.-)```"
}

-- Change model
-- This is actually same with M.select_model()
vim.api.nvim_create_user_command('GenChm', function(arg)
  M.select_model()
  -- if arg.args == "" then
  --   print("Empty input")
  --   return
  -- end
  -- M["model"] = arg.args
  -- print("Change model into " .. M["model"])
end, {
  -- nargs = "?",
  -- complete = function(ArgLead, CmdLine, CursorPos)
  --   return { "codellama", "llama3", "llama3:70b" }
  -- end
})
