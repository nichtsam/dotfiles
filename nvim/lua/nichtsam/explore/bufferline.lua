local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
	return
end

bufferline.setup({
	options = {
		diagnostics = "nvim_lsp",
		indicator = {
			style = "icon",
			icon = "▎",
		},
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer",
				text_align = "left",
				highlight = "WildMenu",
				padding = 1,
			},
		},
		buffer_close_icon = "",
		close_icon = "",
	},
	highlights = {
		fill = {
			fg = { attribute = "fg", highlight = "ff0000" },
			bg = { attribute = "bg", highlight = "@none" },
		},

		background = {
			fg = { attribute = "fg", highlight = "TabLine" },
			bg = { attribute = "bg", highlight = "@none" },
		},

		separator = {
			fg = { attribute = "bg", highlight = "TabLine" },
			bg = { attribute = "bg", highlight = "@none" },
		},
	},
})
