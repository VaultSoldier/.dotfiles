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
          { filetype = 'neo-tree', text = 'File Explorer', highlight = 'Directory', separator = true },
        },
        sort_by = 'insert_after_current',
        separator_style = 'thin', -- "slant" | "thick" | "thin" | { 'any', 'any' }
        tab_size = 10,
        show_close_icon = false,
        show_buffer_close_icons = false,
        color_icons = false,

        diagnostics = 'nvim_lsp',
        diagnostics_update_on_event = true, -- use nvim's diagnostic handler
        -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local icon = level:match 'error' and ' ' or ' '
          return ' ' .. icon .. count
        end,
        custom_filter = function(buf_number, buf_numbers)
          -- filter out filetypes you don't want to see
          if vim.bo[buf_number].filetype ~= 'qf' then
            return true
          end
        end,
      },
    }
  end,
}
