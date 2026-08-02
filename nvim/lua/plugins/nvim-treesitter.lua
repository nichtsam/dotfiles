return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      -- defaults
      "vim",
      "vimdoc",
      "lua",

      -- shell
      "bash",

      -- web dev
      "html",
      "css",
      "javascript",
      "typescript",
      "tsx",
      "json",
      "yaml",

      -- Database
      "sql",

      -- web3
      "solidity",

      -- rust
      "rust",
      "toml",

      -- go
      "go",
      "templ",

      -- python
      "python",

      -- markdown
      "markdown",
      "markdown_inline",
    },
  },
}
