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
  -- Rust
  rust_analyzer = {},
  taplo = {},
  -- Go
  gopls = {},
  templ = {},
  -- Lua
  lua_ls = {},
  -- Dart
  dartls = {},
}

for name, opts in pairs(servers) do
  opts.on_init = nvlsp.on_init
  opts.on_attach = nvlsp.on_attach
  opts.capabilities = nvlsp.capabilities

  if name == "dartls" then
    require("flutter-tools").setup { lsp = opts }
    goto continue
  end

  vim.lsp.enable(name)
  vim.lsp.config(name, opts)

  ::continue::
end
