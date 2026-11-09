return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim', opts = {} }, -- Useful status updates for LSP.
    { 'j-hui/fidget.nvim', opts = {} },
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'saghen/blink.cmp',
  },
  config = function()
    --  This function gets run when an LSP attaches to a particular buffer.
    --    That is to say, every time a new file is opened that is associated with
    --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
    --    function will be executed to configure the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        require('config.keymaps.lsp').Init(map)
        require('config.keymaps.terminal').Lsp(map)

        -- This function resolves a difference between neovim
        -- nightly (version 0.11) and stable (version 0.10)
        ---@param client vim.lsp.Client
        ---@param method vim.lsp.protocol.Method
        ---@param bufnr? integer some lsp support methods only in specific files
        ---@return boolean
        local function client_supports_method(client, method, bufnr)
          return client:supports_method(method, bufnr)
        end

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)

        if client and client.name == 'ruff' then
          client.server_capabilities.hoverProvider = false
        end

        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
          local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
            end,
          })
        end

        -- The following code creates a keymap to toggle inlay hints in your
        -- code, if the language server you are using supports them
        --
        -- This may be unwanted, since they displace some of your code
        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
          end, '[T]oggle Inlay [H]ints')
        end
      end,
    })

    -- Per-server settings. mason-lspconfig auto-enables installed servers via
    -- vim.lsp.enable() (nvim >= 0.11), so settings must be registered with
    -- vim.lsp.config() *before* setup() runs below — the old `handlers` API
    -- was removed from mason-lspconfig and never applied these settings.
    vim.lsp.config('pyright', {
      settings = {
        pyright = {
          disableOrganizeImports = true,
        },
        python = {
          analysis = {
            typeCheckingMode = 'basic',
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = 'workspace',
          },
        },
      },
    })
    vim.lsp.config('ruff', {
      init_options = {
        settings = {
          logLevel = 'info',
        },
      },
    })
    vim.lsp.config('yamlls', {
      filetypes = { 'yaml' },
      settings = {
        redhat = { telemetry = { enabled = false } },
      },
    })
    vim.lsp.config('html', {
      filetypes = { 'html', 'twig', 'hbs' },
    })
    vim.lsp.config('lua_ls', {
      settings = {
        Lua = {
          runtime = { version = 'LuaJIT' },
          workspace = {
            checkThirdParty = false,
            library = {
              '${3rd}/luv/library',
              unpack(vim.api.nvim_get_runtime_file('', true)),
            },
          },
          completion = {
            callSnippet = 'Replace',
          },
          telemetry = { enable = false },
          diagnostics = { disable = { 'missing-fields' } },
        },
      },
    })

    -- `mason` had to be setup earlier: to configure its options see the
    -- `dependencies` table for `nvim-lspconfig` above.
    -- Dart (dartls) is excluded — its LSP ships with the flutter-tools plugin.
    local ensure_installed = {
      -- LSP servers
      'pyright', -- Python
      'ruff', -- Python Formatter/Linter/LSP
      'tombi', -- toml
      'jsonls',
      'sqlls',
      'terraformls',
      'yamlls',
      'dockerls',
      'bashls',
      'docker_compose_language_service',
      'tailwindcss',
      'html',
      'cssls',
      'clangd',
      'gopls',
      'nil_ls',
      'lua_ls',
      'ts_ls',
      -- Formatters / linters used by nvim-lint and conform
      'stylua',
      'prettier',
      'markdownlint',
      'hadolint',
      'prettierd',
      'jsonlint',
      'vale',
      'nixfmt',
      'ansible-lint',
      'shfmt',
    }
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    require('mason-lspconfig').setup {
      ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
    }
  end,
}
