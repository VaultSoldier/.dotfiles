vim.g.have_nerd_font = true
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require 'config.lazy'
require 'config.autocmds'
require 'config.options'
require('config.keymaps').global()

-- session restoration options
vim.opt.sessionoptions = { -- required
  'buffers',
  'tabpages',
  'globals',
  'curdir',
  'folds',
}
