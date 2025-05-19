-- temp solution for switching linters between projects
local function merge(...)
  local result = {}
  for _, t in ipairs { ... } do
    for k, v in pairs(t) do
      result[k] = v
    end
    local mt = getmetatable(t)
    if mt then
      setmetatable(result, mt)
    end
  end
  return result
end

local eslint = {
  javascript = { "eslint" },
  javascriptreact = { "eslint" },
  typescript = { "eslint" },
  typescriptreact = { "eslint" },
}

local biome = {
  javascript = { "biomejs" },
  javascriptreact = { "biomejs" },
  typescript = { "biomejs" },
  typescriptreact = { "biomejs" },
}

require("lint").linters_by_ft = merge(eslint, {
  go = { "golangcilint" },
  solidity = { "solhint" },
})

local group = vim.api.nvim_create_augroup("Lint", { clear = true })
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  group = group,
  callback = function()
    require("lint").try_lint(nil, { ignore_errors = true })
  end,
})
