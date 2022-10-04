-- decide colorscheme
local colorscheme = "tokyonight"

-- setup tokyonight
local tokyonight_ok, tokyonight = pcall(require, "tokyonight")

if not tokyonight_ok then
	vim.notify("tokyonight not found!")
	return
end

tokyonight.setup({
	transparent = true,
})

-- setup colorscheme
local colorscheme_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not colorscheme_ok then
	vim.notify("colorscheme " .. tokyonight .. " not found!")
	return
end

-- Autocommand that sets up neovim coloerscheme
--vim.cmd([[
--    augroup color_scheme
--    autocmd!
--    autocmd User PackerComplete colorscheme ]] .. colorscheme .. [[
--    augroup end
--]])
