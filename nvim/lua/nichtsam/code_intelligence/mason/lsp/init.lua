-- Check for the fundamental
local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("nichtsam.code_intelligence.mason.lsp.register")
require("nichtsam.code_intelligence.mason.lsp.vim_setup")
