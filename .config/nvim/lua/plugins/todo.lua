return {
  'folke/todo-comments.nvim',
  cmd = { 'TodoTrouble', 'TodoTelescope' },
  event = 'VeryLazy',
  opts = {},
    -- stylua: ignore
    keys = require('config.keymaps').todo_keys()
,
}
