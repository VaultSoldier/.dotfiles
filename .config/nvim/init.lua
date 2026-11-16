vim.g.have_nerd_font = true
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local ansible_markers = {
  'ansible.cfg',
  '.ansible.cfg',
  'requirements.yml',
  'requirements.yaml',
  'group_vars',
  'host_vars',
  'molecule',
}
local ansible_cache = {} --- @type table<string, boolean>

---@param dir string
---@return boolean
local function in_ansible_project(dir)
  if ansible_cache[dir] == nil then
    local vcs = vim.fs.root(dir, { '.git', '.hg', '.svn' })
    ansible_cache[dir] = #vim.fs.find(ansible_markers, {
      path = dir,
      upward = true,
      limit = 1,
      stop = vcs and vim.fs.dirname(vcs) or nil,
    }) > 0
  end
  return ansible_cache[dir]
end

--- Filetype function for the ambiguous patterns; {path} is absolute
---@param path? string
---@return string?
local function ansible_ft(path)
  return (path and in_ansible_project(vim.fs.dirname(path)) and 'yaml.ansible') or nil
end

vim.filetype.add {
  pattern = {
    -- unambiguous by path alone
    ['.*/playbooks/.*%.ya?ml'] = { 'yaml.ansible', { priority = 10 } },
    -- anything under roles/<role>/ (tasks, handlers, vars, defaults, meta, ...)
    ['.*/roles/[^/]+/.*%.ya?ml'] = { 'yaml.ansible', { priority = 10 } },
    ['.*/group_vars/.*%.ya?ml'] = { 'yaml.ansible', { priority = 10 } },
    ['.*/host_vars/.*%.ya?ml'] = { 'yaml.ansible', { priority = 10 } },
    ['.*ansible.*%.ya?ml'] = { 'yaml.ansible', { priority = 10 } },
    -- ambiguous directory names: only inside something that looks like ansible
    ['.*/tasks/.*%.ya?ml'] = { ansible_ft, { priority = 5 } },
    ['.*/handlers/.*%.ya?ml'] = { ansible_ft, { priority = 5 } },
    ['.*/vars/.*%.ya?ml'] = { ansible_ft, { priority = 5 } },
    ['.*/defaults/.*%.ya?ml'] = { ansible_ft, { priority = 5 } },
    ['.*/site%.ya?ml'] = { ansible_ft, { priority = 5 } },
    ['.*/inventories/.*%.ya?ml'] = { ansible_ft, { priority = 5 } },
    ['.*/inventory/.*%.ya?ml'] = { ansible_ft, { priority = 5 } },
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
