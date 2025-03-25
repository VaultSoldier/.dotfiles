return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    local bufferline = require 'bufferline'
    bufferline.setup {
      options = {
        mode = 'buffers', -- set to "tabs" to show tabs instead
        numbers = 'ordinal', -- "none" | "ordinal" | "buffer_id"
        close_command = 'bdelete! %d',
        offsets = {
          { filetype = 'NvimTree', text = 'File Explorer', highlight = 'Directory' },
        },
        separator_style = 'thin', -- "slant" | "thick" | "thin" | { 'any', 'any' }
        show_close_icon = false,
        color_icons = true,
      },
    }
  end,
}
