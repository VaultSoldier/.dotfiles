local lspconfig = require 'lspconfig'
local map = vim.keymap.set

-- Define the language servers you want to use
local servers = {
  pyright = {}, -- Python
  ts_ls = {}, -- JavaScript/TypeScript
  lua_ls = {}, -- Lua
  clangd = {}, -- C/C++
  rust_analyzer = {}, -- Rust
}

-- Common on_attach function (optional)
local on_attach = function(client, bufnr)
  -- Keybindings for LSP
  local opts = { noremap = true, buffer = bufnr }
  map('n', 'gd', vim.lsp.buf.definition, opts)
  map('n', 'K', vim.lsp.buf.hover, opts)
  map('n', '<leader>ca', vim.lsp.buf.rename, vim.tbl_extend('force', opts, { desc = 'LSP renamer' }))
end

-- Loop through each server and setup
for server, config in pairs(servers) do
  config.on_attach = on_attach
  lspconfig[server].setup(config)
end
