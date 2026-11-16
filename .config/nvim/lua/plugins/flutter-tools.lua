return {
  'nvim-flutter/flutter-tools.nvim',
  ft = { 'dart', 'flutter' },
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    require('flutter-tools').setup {}
  end,
}
