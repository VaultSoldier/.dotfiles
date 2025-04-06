return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup {
      -- Configuration below
      section = {
        lualine_c = {
          { 'filename', path = 1 },
          {
            require('nvim-possession').status,
            cond = function()
              return require('nvim-possession').status() ~= nil
            end,
          },
        },
      },
    }
  end,
}
