return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "nvchad.configs.lspconfig"
      require "configs.lspconfig"
    end,
  },

  { "b0o/schemastore.nvim" },

  {
    "antosha417/nvim-lsp-file-operations",
    config = true,
    event = "User FilePost",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-tree.lua",
    },
  },
}
