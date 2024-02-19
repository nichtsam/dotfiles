local M = {}

M.general = {
  n = {
    ["<leader>fm"] = {
      function()
        require("conform").format({ async = true, lsp_fallback = true, })
      end,
      "Format"
    },
  },
}

return M
