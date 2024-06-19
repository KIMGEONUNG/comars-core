local previewers = require('telescope.previewers')
local bad_extentions = { '.*%.csv', '.*%.json' }
local size_max = 100000
local bad_files = function(filepath)
  for _, v in ipairs(bad_extentions) do
    if filepath:match(v) then
      return true
    end
  end
  return false
end

-- Telescop previewer freezes when attempting to preview large files.
-- 'new_maker' excludes the files having large size or specific file extension.
local custom_previewer_maker = function(filepath, bufnr, opts)
  filepath = vim.fn.expand(filepath)
  stat = vim.loop.fs_stat(filepath)

  if not stat then return end
  if stat.size > size_max then return end
  if bad_files(filepath) then return end
  previewers.buffer_previewer_maker(filepath, bufnr, opts)
end

require('telescope').setup {
  defaults = {
    buffer_previewer_maker = custom_previewer_maker,
    preview = {
    },
    file_ignore_patterns = { '%.pyc',
      -- '.git/*',
      '__pycache__/*',
      '%.jpeg', '%.jpg', '%.JPEG', '%.png', '%.gif', '%.dat',
      '%.pkl', '%.ckpt', '%.pickle', 'events.*', '%.tfrecords',
      '%.xyzn', '%.xyz', '%.obj', '%.ply'
    }
  },
  pickers = {
    find_files = {
      theme = "dropdown",
    }
  },
  -- Telescope selection UI
  -- This is your opts table
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      },
      specific_opts = {
        codeactions = true,
      },

      -- pseudo code / specification for writing custom displays, like the one
      -- for "codeactions"
      -- specific_opts = {
      --   [kind] = {
      --     make_indexed = function(items) -> indexed_items, width,
      --     make_displayer = function(widths) -> displayer
      --     make_display = function(displayer) -> function(e)
      --     make_ordinal = function(e) -> string
      --   },
      --   -- for example to disable the custom builtin "codeactions" display
      --      do the following
      --   codeactions = false,
      -- }
    }
  }
}

local remap = vim.keymap.set
remap('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { noremap = true, silent = true })
remap('n', '<leader>fg', ':Telescope live_grep<cr>', { noremap = true, silent = true })
remap('n', '<leader>fb', ':Telescope buffers<cr>', { noremap = true, silent = true })
remap('n', '<leader>fh', ':Telescope help_tags<cr>', { noremap = true, silent = true })


-- To get ui-select loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require("telescope").load_extension("ui-select")
-- require("telescope").load_extension("noice")
