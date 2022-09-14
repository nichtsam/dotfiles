local status_ok, opts = pcall(require, "nichtsam.mason.lsp.settings.opts")
if not status_ok then
	return
end

require("mason-lspconfig").setup_handlers({
    function (server_name)
        require("lspconfig")[server_name].setup(opts)
    end,
    ["sumneko_lua"] = function ()
        require("lspconfig").sumneko_lua.setup(vim.tbl_deep_extend("force", opts, require("nichtsam.mason.lsp.settings.sumneko_lua")))
    end
})
