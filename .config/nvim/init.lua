vim.g.have_nerd_font = true
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.filetype.add {
  pattern = {
    ['.*/playbooks/.*%.ya?ml'] = 'yaml.ansible',
    ['.*/tasks/.*%.ya?ml'] = 'yaml.ansible',
    ['.*/handlers/.*%.ya?ml'] = 'yaml.ansible',
    ['.*/roles/.*/.*%.ya?ml'] = 'yaml.ansible',
    ['.*/defaults/.*%.ya?ml'] = 'yaml.ansible',
    ['.*/vars/.*%.ya?ml'] = 'yaml.ansible',
    ['.*ansible.*%.ya?ml'] = 'yaml.ansible',
  },
}

require 'config.lazy'
require 'config.autocmds'
require 'config.options'
require 'config.keymaps.find'
require('config.keymaps.global').Init()
require('config.keymaps.terminal').Init()

-- session restoration options
vim.opt.sessionoptions = { -- required
  'buffers',
  'tabpages',
  'globals',
  'curdir',
  'folds',
}
