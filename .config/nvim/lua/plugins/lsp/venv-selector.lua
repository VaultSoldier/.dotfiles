return {
  'linux-cultist/venv-selector.nvim',
  lazy = true,
  ft = 'python', -- Load when opening Python files
  dependencies = {
    { 'nvim-telescope/telescope.nvim', version = '*', dependencies = { 'nvim-lua/plenary.nvim' } }, -- optional: you can also use fzf-lua, snacks, mini-pick instead.
  },
  config = function()
    require('venv-selector').setup()

    vim.keymap.set('n', '<leader>cpv', '<cmd>VenvSelect<cr>')
    vim.keymap.set('n', '<leader>cps', '<cmd>VenvSelect<cr>')
  end,
  opts = {
    options = {}, -- plugin-wide options
    search = {}, -- custom search definitions
  },
}
