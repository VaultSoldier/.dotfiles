local M = {}

function M.Init(map)
  -- venv-selector
  map('<leader>cps', '<cmd>VenvSelect<cr>', 'Pick venv')
  map('<leader>cpc', '<cmd>VenvSelectCached<cr>', 'Load venv from cache')

  map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
  map('<leader>cn', vim.lsp.buf.rename, '[R]e[n]ame')
  map('<leader>cf', function()
    require('conform').format {
      lsp_format = 'fallback',
      timeout_ms = 1000,
    }
  end, 'Format code with conform', { 'n', 'v' })

  map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

  -- Code --
  map('<leader>E', vim.diagnostic.open_float, 'Diagnostic [E]rror messages')
  map('<leader>q', vim.diagnostic.setloclist, 'Diagnostic [Q]uickfix list')

  map('[d', function()
    vim.diagnostic.jump { count = -1 }
  end, 'Go to previous [D]iagnostic message')

  map(']d', function()
    vim.diagnostic.jump { count = 1 }
  end, 'Go to next [D]iagnostic message')
end

return M
