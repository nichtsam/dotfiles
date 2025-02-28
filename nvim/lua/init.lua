local autocmd = vim.api.nvim_create_autocmd

-------------------------------------- autocmd ------------------------------------------
autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    client.server_capabilities.semanticTokensProvider = nil
  end,
})

-------------------------------------- filetype -----------------------------------------
vim.filetype.add {
  extension = {
    templ = "templ",
  },
  pattern = {
    ["%.env%..+"] = "sh",
  },
}
