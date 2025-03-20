vim.g.have_nerd_font = true
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local plugins = {
  'init',
  'kickstart',
  'which-key',
  'telescope',
  'autopairs',
  'debug',
  'gitsigns',
  'indent-line',
  'lint',
  'neo-tree',
  'nvim-cmp',
  'scope-nvim',
  'theme',
  'venv-selector',
}

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require 'configs.lazy'
require 'options'
require 'autocmds'

for _, plugin in ipairs(plugins) do
  require('plugins.' .. plugin)
end

vim.schedule(function()
  require 'mappings'
end)
