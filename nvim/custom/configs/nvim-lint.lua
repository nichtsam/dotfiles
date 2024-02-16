require('lint').linters_by_ft = {
  javascript = { "eslint" },
  javascriptreact = { "eslint" },
  typescript = { "eslint" },
  typescriptreact = { "eslint" },

  go = { "golangcilint" }
}

local group = vim.api.nvim_create_augroup("Lint", { clear = true })
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  group = group,
  callback = function()
    require("lint").try_lint()
  end,
})
