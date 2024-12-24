require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<leader>lf", "<cmd>lua vim.diagnostic.open_float()<CR>", { desc = "Show diagnostics under the cursor" })
map("n", "<leader>fm", function()
  require("conform").format { async = true, lsp_fallback = true }
end, { desc = "Format" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")k
