local options = {
  lsp_fallback = true,

  formatters = {
    biome = {
      require_cwd = true,
    },
  },

  formatters_by_ft = {

    javascript = { "prettier", "biome", stop_after_first = true },
    javascriptreact = { "prettier", "biome", stop_after_first = true },
    typescript = { "prettier", "biome", stop_after_first = true },
    typescriptreact = { "prettier", "biome", stop_after_first = true },
    vue = { "prettier" },
    css = { "prettier", "biome", stop_after_first = true },
    scss = { "prettier" },
    less = { "prettier" },
    html = { "prettier" },
    json = { "prettier", "biome", stop_after_first = true },
    jsonc = { "prettier", "biome", stop_after_first = true },
    yaml = { "prettier" },
    markdown = { "prettier" },
    ["markdown.mdx"] = { "prettier" },
    graphql = { "prettier", "biome", stop_after_first = true },
    handlebars = { "prettier" },

    rust = { "rustfmt" },

    go = {
      "gofumpt",
      "goimports-reviser",
      "golines",
    },

    templ = {
      "templ",
    },

    lua = { "stylua" },

    dart = { "dart_format" },
  },

  format_on_save = function(bufnr)
    -- Disable with a global or buffer-local variable
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    return { timeout_ms = 500, lsp_fallback = true }
  end,
}

require("conform").setup(options)

vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = "Disable autoformat-on-save",
  bang = true,
})

vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = "Re-enable autoformat-on-save",
})
