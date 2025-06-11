return {
  -- Change the name of the colorscheme plugin below, and then
  -- change the command in the config to whatever the name of that colorscheme is.
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
    -- Many themes have different styles, and you could load
    -- any other, such as 'tokyonight-storm', 'tokyonight-moon' etc.
    vim.cmd.colorscheme 'tokyonight-night'
  end,
}
