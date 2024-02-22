local plugins = {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- defaults
        "vim",
        "lua",

        -- web dev
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "json",

        -- rust
        "rust",
        "toml",

        -- go
        "go",
        "templ"
      },
    },
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- Web
        -- lsp
        "html-lsp",
        "css-lsp",
        "typescript-language-server",
        "tailwindcss-language-server",
        -- formatter
        "prettier",
        -- linter
        "eslint-lsp",

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

        -- Lua
        -- formatter
        "stylua",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("plugins.configs.lspconfig")
      require("custom.configs.lspconfig")
    end,
  },

  {
    "stevearc/conform.nvim",
    --  for users those who want auto-save conform + lazyloading!
    event = "BufWritePre",
    config = function()
      require("custom.configs.conform")
    end,
  },

  {
    "mfussenegger/nvim-lint",
    event = "BufWritePost",
    config = function()
      require("custom.configs.nvim-lint")
    end,
  },

  { 'wakatime/vim-wakatime', lazy = false }
}

return plugins
