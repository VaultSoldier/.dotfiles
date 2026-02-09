return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  config = function()
    local filetypes = {
      'python',
      'dart',
      'go',
      'nix',
      'c',
      'bash',
      'diff',
      'javascript',
      'javadoc',
      'html',
      'json',
      'css',
      'ini',
      'lua',
      'luadoc',
      'desktop',
      'hyprlang',
      'markdown',
      'markdown_inline',
      'dockerfile',
      'gitcommit',
      'git_rebase',
      'gitignore',
      'query',
      'vim',
      'vimdoc',
    }
    require('nvim-treesitter').install(filetypes)
    vim.api.nvim_create_autocmd('FileType', {
      pattern = filetypes,
      callback = function()
        vim.treesitter.start()
      end,
    })
  end,
}
