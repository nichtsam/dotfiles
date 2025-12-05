require("nvchad.configs.lspconfig").defaults()

local nvlsp = require "nvchad.configs.lspconfig"

local servers = {
  -- Web
  html = {},
  cssls = {},
  tailwindcss = {
    settings = {
      tailwindCSS = {
        experimental = {
          classRegex = {
            { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
            { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
          },
        },
      },
    },
  },
  ts_ls = {},
  -- Web3
  solidity = {},
  -- Rust
  rust_analyzer = {},
  taplo = {},
  -- Go
  gopls = {},
  templ = {},
  -- Python
  pyright = {},
  ruff = {},
  -- Lua
  lua_ls = {},
}

for name, opts in pairs(servers) do
  opts.on_init = nvlsp.on_init
  opts.on_attach = nvlsp.on_attach
  opts.capabilities = nvlsp.capabilities

  vim.lsp.enable(name)
  vim.lsp.config(name, opts)
end
