return {
  'williamboman/mason.nvim',
  opts = {
    ensure_installed = {
      'lua-language-server',
      'stylua',
      'ts_ls',
      'html-lsp',
      'css-lsp',
      'prettier',
      'markdownlint',
      'pyright',
    },
  },
  config = function()
    require('mason').setup()
  end,
}
