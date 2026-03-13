return {
  'stevearc/conform.nvim',
  event = 'BufWritePre', -- uncomment for format on save
  config = function()
    local options = {
      formatters_by_ft = {
        python = {
          -- To fix auto-fixable lint errors.
          'ruff_fix',
          -- To run the Ruff formatter.
          'ruff_format',
          -- To organize the imports.
          'ruff_organize_imports',
        },
        go = { 'gofmt' },
        dart = { 'dart_format' },
        toml = { 'tombi' },
        lua = { 'stylua' },
        javascript = { 'prettierd', 'prettier' },
        css = { 'prettier' },
        html = { 'prettier' },
        json = { 'prettier' },
        yaml = { 'prettier' },
        markdown = { 'markdownlint' },
        terraform = { 'terraform' },
        sh = { 'shfmt' },
        bash = { 'shfmt' },
        mksh = { 'shfmt' },
        shell = { 'shfmt' },
        nix = { 'nixfmt' },
      },
      formatters = {
        gofmt = {
          command = 'gofmt',
        },
        dart_format = {
          command = 'dart',
          args = { 'format' },
          stdin = true,
        },
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
