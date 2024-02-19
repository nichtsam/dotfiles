local configs = require("plugins.configs.lspconfig")
local on_attach = configs.on_attach
local capabilities = configs.capabilities

local lspconfig = require("lspconfig")
local servers = {
  -- Web
  "html",
  "cssls",
  "tailwindcss",
  "tsserver",
  -- Rust
  "rust_analyzer",
  "taplo",
  -- Go
  "gopls",
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end
