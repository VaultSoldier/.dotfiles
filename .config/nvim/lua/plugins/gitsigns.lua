return {
  'lewis6991/gitsigns.nvim',
  opjs = {
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "" },
      topdelete = { text = "" },
      changedelete = { text = "▎" },
      untracked = { text = "▎" },
    },
    signs_staged = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "" },
      topdelete = { text = "" },
      changedelete = { text = "▎" },
    },

    on_attach = function(bufnr)
      local gitsigns = require 'gitsigns'
      require('config.keymaps').gitsigns(bufnr, gitsigns)
    end,
  },
}
