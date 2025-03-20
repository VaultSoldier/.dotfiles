return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
    'hrsh7th/cmp-buffer', -- Buffer words completion
    'hrsh7th/cmp-path', -- Path completion
    'hrsh7th/cmp-cmdline', -- Command-line completion
    'L3MON4D3/LuaSnip', -- Snippets
    'saadparwaiz1/cmp_luasnip', -- Snippet completion
  },
  config = function()
    local cmp = require 'cmp'

    cmp.setup {
      mapping = cmp.mapping.preset.insert {
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<CR>'] = cmp.mapping.confirm { select = true },
        ['<C-Space>'] = cmp.mapping.complete(),
      },
      sources = cmp.config.sources {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
      },
    }

    -- Enable completion in command mode
    cmp.setup.cmdline('/', {
      sources = { { name = 'buffer' } },
    })

    cmp.setup.cmdline(':', {
      sources = cmp.config.sources {
        { name = 'path' },
        { name = 'cmdline' },
      },
    })
  end,
}
