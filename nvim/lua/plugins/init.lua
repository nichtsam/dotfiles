local plugins = {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- defaults
        "vim",
        "vimdoc",
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
        "templ",

        -- markdown
        "markdown",
        "markdown_inline",
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
        "biome",

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
        -- lsp
        "lua",
        -- formatter
        "stylua",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "nvchad.configs.lspconfig"
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-flutter/flutter-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  {
    "antosha417/nvim-lsp-file-operations",
    config = true,
    event = "User FilePost",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-tree.lua",
    },
  },

  {
    "davidmh/mdx.nvim",
    lazy = false,
    config = true,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },

  {
    "folke/snacks.nvim",
    event = "VeryLazy",
    opts = {
      input = { enabled = true },
      image = { enabled = true },
      picker = { enabled = true },
    },
  },

  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
      require "configs.conform"
    end,
  },

  {
    "mfussenegger/nvim-lint",
    event = "BufWritePost",
    config = function()
      require "configs.nvim-lint"
    end,
  },

  { "wakatime/vim-wakatime", lazy = false },

  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
  },
}

return plugins
