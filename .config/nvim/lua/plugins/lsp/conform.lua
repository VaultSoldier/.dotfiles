return {
  'stevearc/conform.nvim',
  event = 'BufWritePre', -- uncomment for format on save
  config = function()
    local options = {
      formatters_by_ft = {
        python = { 'black' },
        lua = { 'stylua' },
        javascript = { 'prettierd', 'prettier' },
        css = { 'prettier' },
        html = { 'prettier' },
        bash = { 'shfmt' },
        mksh = { 'shfmt' },
        shell = { 'shfmt' },
        nix = { 'nixfmt' },
      },

      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_fallback = true,
      },
    }

    require('conform').setup(options)
  end,
}
