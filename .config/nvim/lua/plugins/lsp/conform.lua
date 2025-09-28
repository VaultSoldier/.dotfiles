return {
  'stevearc/conform.nvim',
  event = 'BufWritePre', -- uncomment for format on save
  config = function()
    local options = {
      formatters_by_ft = {
        python = { 'black' },
        dart = { 'dcm' },
        toml = { 'tombi' },
        lua = { 'stylua' },
        javascript = { 'prettierd', 'prettier' },
        css = { 'prettier' },
        html = { 'prettier' },
        json = { 'prettier' },
        yaml = { 'prettier' },
        bash = { 'shfmt' },
        mksh = { 'shfmt' },
        shell = { 'shfmt' },
        nix = { 'nixfmt' },
      },

      -- format_on_save = {
      --   -- These options will be passed to conform.format()
      --   timeout_ms = 500,
      --   lsp_format = 'fallback',
      -- },
    }

    require('conform').setup(options)
  end,
}
