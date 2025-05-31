require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<leader>gd", "gd", { desc = "LSP Go to definition" })
map("n", "<leader>gD", "gD", { desc = "LSP Go to declaration" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
map("n", "<leader>lf", vim.diagnostic.open_float, { desc = "Show diagnostics under the cursor" })
map("n", "<leader>fm", function()
  require("conform").format { async = true, lsp_fallback = true }
end, { desc = "Format" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")k
