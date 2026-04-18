local nvlint = require "lint"

nvlint.linters_by_ft = {

  javascript = { "eslint" },
  javascriptreact = { "eslint" },
  typescript = { "eslint" },
  typescriptreact = { "eslint" },

  -- javascript = { "biomejs" },
  -- javascriptreact = { "biomejs" },
  -- typescript = { "biomejs" },
  -- typescriptreact = { "biomejs" },

  go = { "golangcilint" },
  solidity = { "solhint" },
  python = { "ruff" },
  -- yaml = { "vacuum" },
  -- json = { "vacuum" },
}

local group = vim.api.nvim_create_augroup("Lint", { clear = true })
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  group = group,
  callback = function()
    nvlint.try_lint(nil, { ignore_errors = true })
  end,
})
