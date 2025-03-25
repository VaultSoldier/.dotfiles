return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  opts = function()
    return {}
  end,
  config = function()
    require('which-key').setup()
    require('which-key').add {
      { '<leader>c', group = 'Code' },
      { '<leader>f', group = 'Find' },
      { '<leader>s', group = 'Search' },
      { '<leader>w', group = 'Workspace' },
      { '<leader>D', group = 'Document' },
      { '<leader>d', group = 'Debug' },
      { '<leader>g', group = 'Git' },
      { '<leader>t', group = 'Toggle' },
    }
  end,
}
