local nvlsp = require "nvchad.configs.lspconfig"
local lspconfig = require "lspconfig"

-- nvlsp.defaults() -- loads nvchad's defaults

local servers = { "html", "cssls", "clangd", "pyright" }


local function custom_on_attach(client, bufnr)
  -- Call the original NvChad on_attach
  if nvlsp.on_attach then
    nvlsp.on_attach(client, bufnr)
  end

  -- Unmap <leader>ra
  vim.keymap.del("n", "<leader>ra", { buffer = bufnr })
end

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = custom_on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end
