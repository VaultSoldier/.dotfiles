return {
  'linux-cultist/venv-selector.nvim',
  lazy = true,
  ft = 'python', -- Load when opening Python files
  config = function()
    require('venv-selector').setup()

    vim.keymap.set('n', '<leader>cpv', '<cmd>VenvSelect<cr>')
  end,
}
