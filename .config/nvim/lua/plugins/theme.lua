return {
  -- To see installed colorschemes, use `:Telescope colorscheme`.
  'folke/tokyonight.nvim',

  priority = 1000, -- load before all other.
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('tokyonight').setup {
      transparent = true,
      styles = {
        comments = { italic = false }, -- Disable italics in comments
      },
    }
    vim.cmd.colorscheme 'tokyonight-night'
  end,
}
