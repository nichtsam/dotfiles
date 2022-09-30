-- Check for general options
local opts_ok, opts = pcall(require, "nichtsam.mason.lsp.settings.opts")
if not opts_ok then
	return
end

local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_ok then
	return
end

mason_lspconfig.setup({
	-- names in https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
	ensure_installed = {
		"sumneko_lua",
		"rust_analyzer",
		"eslint",
		"taplo",
		"jsonls",
		"tsserver",
	},
	automatic_installation = true,
})

mason_lspconfig.setup_handlers({
	-- Basic register
	function(server_name)
		require("lspconfig")[server_name].setup(opts)
	end,
	-- lua specific register
	["sumneko_lua"] = function()
		require("lspconfig").sumneko_lua.setup(
			vim.tbl_deep_extend("force", opts, require("nichtsam.mason.lsp.settings.sumneko_lua"))
		)
	end,
	-- json specific register
	["jsonls"] = function()
		require("lspconfig").jsonls.setup(
			vim.tbl_deep_extend("force", opts, require("nichtsam.mason.lsp.settings.jsonls"))
		)
	end,
})
