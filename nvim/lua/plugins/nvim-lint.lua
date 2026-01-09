return {
  "mfussenegger/nvim-lint",
  event = "BufWritePost",
  config = function()
    require "configs.nvim-lint"
  end,
}
