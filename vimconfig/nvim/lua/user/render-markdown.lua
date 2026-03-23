vim.api.nvim_set_hl(0, 'RenderMarkdownH1Bg', { bg = '#4b224a' })
vim.api.nvim_set_hl(0, 'RenderMarkdownH2Bg', { bg = '#234e52' })
vim.api.nvim_set_hl(0, 'RenderMarkdownH3Bg', { bg = '#3f5f2f' })
vim.api.nvim_set_hl(0, 'RenderMarkdownH4Bg', { bg = '#6b4f2a' })
vim.api.nvim_set_hl(0, 'RenderMarkdownH5Bg', { bg = '#3d3d73' })
vim.api.nvim_set_hl(0, 'RenderMarkdownH6Bg', { bg = '#5a2f2f' })

require('render-markdown').setup({
  heading = {
    position = 'inline',
    left_margin = 0,
    left_pad = 0,
    sign = false,
    width = 'full',
    backgrounds = {
      'RenderMarkdownH1Bg',
      'RenderMarkdownH2Bg',
      'RenderMarkdownH3Bg',
      'RenderMarkdownH4Bg',
      'RenderMarkdownH5Bg',
      'RenderMarkdownH6Bg',
    },
  },
  indent = {
    enabled = false,
    per_level = 2,
    skip_level = 1,
    skip_heading = false,
  },
})
