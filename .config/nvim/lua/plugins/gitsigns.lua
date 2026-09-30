return {
  'lewis6991/gitsigns.nvim',
  opts = {
    current_line_blame_opts = {
      delay = 100,
    },
    signs = {
      add = { text = '+' },
      change = { text = '±' },
      delete = { text = '-' },
      topdelete = { text = '-' },
      changedelete = { text = '±' },
      untracked = { text = '●' },
    },
    signs_staged = {
      add = { text = '+' },
      change = { text = '±' },
      delete = { text = '-' },
      topdelete = { text = '-' },
      changedelete = { text = '±' },
    },

    on_attach = function(bufnr)
      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      require('config.keymaps.git').Init(map)
    end,
  },
}
