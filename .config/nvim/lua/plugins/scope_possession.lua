return {
  { 'tiagovla/scope.nvim', config = true },

  {
    'gennaro-tedesco/nvim-possession',
    lazy = false,
    dependencies = {
      {
        'ibhagwan/fzf-lua',
        'tiagovla/scope.nvim',
        lazy = false,
        config = true,
      },
    },
    config = function()
      require('nvim-possession').setup {
        autoload = true,
        autoswitch = {
          enable = true, -- whether to enable autoswitch
          exclude_ft = {}, -- list of filetypes to exclude from autoswitch
        },
        plugins = {
          delete_hidden_buffers = true,
        },
        save_hook = function()
          vim.cmd [[ScopeSaveState]] -- Scope.nvim saving
          -- require('neo-tree.command').execute { action = 'close' }
        end,
        post_hook = function()
          vim.cmd [[ScopeLoadState]] -- Scope.nvim loading
          -- require('neo-tree.command').execute { action = 'show', reveal = true }
        end,

        ---@type possession.Hls
        fzf_hls = {
          normal = 'Normal',
          preview_normal = 'Normal',
          -- border = 'Todo',
          preview_border = 'Constant',
        },
        ---@type possession.Winopts
        fzf_winopts = {
          width = 0.5,
          preview = {
            vertical = 'right:30%',
          },
        },
        ---@type possession.Mapopts
        mappings = { -- configure action keymaps on possession.list() picker
          action_delete = 'ctrl-d', -- remap from ctrl+x cuz of global ctrl+x escape keymap
          action_rename = 'ctrl-r',
          action_new = 'ctrl-n',
        },
        sort = require('nvim-possession.sorting').alpha_sort,
      }
    end,
  },
}
