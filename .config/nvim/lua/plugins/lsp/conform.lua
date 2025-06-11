return {
  'stevearc/conform.nvim',
  event = 'BufWritePre', -- uncomment for format on save
  config = function()
    local options = {
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'prettierd', 'prettier' },
        css = { 'prettier' },
        html = { 'prettier' },
        sh = { 'bashls' },
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
