local status_ok, comment = pcall(require, "comment")
if not status_ok then
	return
end

comment.setup({
	ignore = "^$",
	pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
})
