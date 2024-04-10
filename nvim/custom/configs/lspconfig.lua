local configs = require("plugins.configs.lspconfig")
local on_attach = configs.on_attach
local capabilities = configs.capabilities

local lspconfig = require("lspconfig")
local servers = {
  -- Web
  "html",
  "cssls",
  {
    "tailwindcss",
    settings = {
      tailwindCSS = {
        experimental = {
          classRegex = {
            { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
            { "cx\\(([^)]*)\\)",  "(?:'|\"|`)([^']*)(?:'|\"|`)" }
          },
        },
      },
    }
  },
  "tsserver",
  -- Rust
  "rust_analyzer",
  "taplo",
  -- Go
  "gopls",
  "templ"
}

local base = {
  on_attach = on_attach,
  capabilities = capabilities,
}

for _, lsp in ipairs(servers) do
  if type(lsp) == "string" then
    local name = lsp
    lspconfig[name].setup(base)
  else
    local name = table.remove(lsp, 1)
    local config = lsp
    lspconfig[name].setup(vim.tbl_deep_extend("force", base, config))
  end
end
