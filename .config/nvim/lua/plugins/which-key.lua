return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  opts = function()
    return {}
  end,
  config = function()
    require('which-key').setup()
    require('which-key').add {
      { '<leader>c', group = '[C]ode', icon = { icon = '', color = 'green'}},
      { '<leader>f', group = '[F]ind', icon = { icon = '', color = 'green' }},
      { '<leader>a', group = 'Document [A]ction', icon = { icon = '󰈙', color = 'green' }},
      { '<leader>g', group = '[G]it', icon = { icon = '', color = 'yellow' }},
      { '<leader>h', group = 'Git [H]unk', icon = { icon = '', color = 'yellow' }},
      { '<leader>t', group = '[T]oggle', icon = { icon = '', color = 'green' }},

      { '<leader>n', icon = { icon = '󰂚 ', color = 'green' }},
      { '<leader>x', icon = { icon = '', color = 'red' }},
      { '<leader>e', icon = { icon = '󰪶', color = 'green' }},
    }
  end,
}
