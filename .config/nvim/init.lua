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

-- Don't let the snacks dashboard steal startup when nvim-possession will
-- autoload a session for the current directory. The dashboard decides on
-- UIEnter, which fires before possession's scheduled session :source runs,
-- so it opens on the empty first buffer and then fights the restored tabs.
-- This must be registered before lazy.nvim loads (snacks registers its own
-- UIEnter callback during plugin load; callbacks run in registration order).
if vim.fn.argc() == 0 then
  vim.api.nvim_create_autocmd('UIEnter', {
    once = true,
    desc = 'Disable snacks dashboard when a possession session will autoload',
    group = vim.api.nvim_create_augroup('dashboard-session-guard', { clear = true }),
    callback = function()
      local ok, snacks = pcall(require, 'snacks')
      if not ok then
        return
      end
      local dash = snacks.config and snacks.config.dashboard
      if dash and dash.enabled then
        local pok, utils = pcall(require, 'nvim-possession.utils')
        if pok then
          -- Same check possession uses to decide whether to autoload
          local sessions = utils.list_sessions(require 'nvim-possession.config', vim.fn.getcwd())
          if #sessions > 0 then
            dash.enabled = false
          end
        end
      end
    end,
  })
end

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
