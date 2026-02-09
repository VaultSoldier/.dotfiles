return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate', -- ensures parsers are updated
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

    require('nvim-treesitter.configs').setup {
      ensure_installed = filetypes,
      highlight = { enable = true },
      indent = { enable = true },
    }
  end,
}
