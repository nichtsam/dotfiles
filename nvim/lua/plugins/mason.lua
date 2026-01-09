return {
  "mason-org/mason.nvim",
  opts = {
    ensure_installed = {
      "terraform-ls",
      -- Shell
      "shfmt",

      -- Web
      -- lsp
      "html-lsp",
      "css-lsp",
      "typescript-language-server",
      "tailwindcss-language-server",
      "json-lsp",
      "yaml-language-server",
      -- formatter
      "prettier",
      -- linter
      "eslint-lsp",
      "biome",

      -- Web3
      -- lsp
      "solidity-ls",
      -- linter
      "solhint",

      -- Rust
      -- lsp
      "rust-analyzer",
      "taplo",

      -- Go
      -- lsp
      "gopls",
      "templ",
      -- formatter
      "gofumpt",
      "goimports-reviser",
      "golines",
      -- linter
      "golangci-lint",

      -- Python
      "pyright",
      "ruff",

      -- Lua
      -- lsp
      "lua",
      -- formatter
      "stylua",

      -- Open API
      "vacuum",
    },
  },
}
