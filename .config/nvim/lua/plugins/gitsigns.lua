return {
  'lewis6991/gitsigns.nvim',
  opts = {
    -- temporary cuz of nvim: /usr/src/debug/neovim/neovim/src/nvim/decoration.c:1066: buf_signcols.count_range
    signcolumn = false,

    signs = {
      add = { text = '▎' },
      change = { text = '▎' },
      delete = { text = '' },
      topdelete = { text = '' },
      changedelete = { text = '▎' },
      untracked = { text = '▎' },
    },
    signs_staged = {
      add = { text = '▎' },
      change = { text = '▎' },
      delete = { text = '' },
      topdelete = { text = '' },
      changedelete = { text = '▎' },
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
