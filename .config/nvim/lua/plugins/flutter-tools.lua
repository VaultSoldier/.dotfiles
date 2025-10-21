return {
  'nvim-flutter/flutter-tools.nvim',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    require('flutter-tools').setup {
      lsp = {
        color = { -- show the derived colours for dart variables
          enabled = true, -- whether or not to highlight color variables
          background = true, -- highlight the background
          ---@diagnostic disable-next-line: assign-type-mismatch
          background_color = { r = 19, g = 17, b = 24 }, -- required, when background is transparent (i.e. background_color = { r = 19, g = 17, b = 24},)
          foreground = false, -- highlight the foreground
          virtual_text = true, -- show the highlight using virtual text
          virtual_text_str = '■', -- the virtual text character to highlight
        },
      },
    }
  end,
}
