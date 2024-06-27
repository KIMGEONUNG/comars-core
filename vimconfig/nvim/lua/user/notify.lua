-- print(require('inspect')(vim.notify))

-- local original_notify = vim.notify
-- vim.notify = function(msg, level, opts)
--     -- Check if the message level is error or warning
--     if level == vim.log.levels.ERROR or level == vim.log.levels.WARN then
--         require("notify")(msg, level, opts)  -- Call your custom function
--     end
--
--     -- Call the original notify function to ensure normal behavior
--     original_notify(msg, level, opts)
-- end
--

-- vim.notify = require("notify")

-- vim.notify("This is an error message.\nSomething went wrong!", "error", {
--   title = plugin,
--   on_open = function()
--     vim.notify("Attempting recovery.", vim.log.levels.WARN, {
--       title = plugin,
--     })
--     local timer = vim.loop.new_timer()
--     timer:start(2000, 0, function()
--       vim.notify({ "Fixing problem.", "Please wait..." }, "info", {
--         title = plugin,
--         timeout = 3000,
--         on_close = function()
--           vim.notify("Problem solved", nil, { title = plugin })
--           vim.notify("Error code 0x0395AF", 1, { title = plugin })
--         end,
--       })
--     end)
--   end,
-- })

local levels = vim.log.levels

-- vim.notify("This is an info message", levels.INFO, { title = "Info" })
-- vim.notify("This is an warn message", levels.WARN, { title = "Warning" })
-- vim.notify("This is an error message", levels.ERROR, { title = "Error" })
