return {
  'folke/todo-comments.nvim',
  cmd = { 'TodoTrouble', 'TodoTelescope' },
  event = 'VeryLazy',
  opts = {},
  init = function()
    require 'config.keymaps.todo'
  end,
}
