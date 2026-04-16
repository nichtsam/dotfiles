return {
  "nvim-treesitter/nvim-treesitter",
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
