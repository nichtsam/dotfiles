local colorscheme = "tokyonight"

vim.g.tokyonight_transparent_sidebar = true
vim.g.tokyonight_transparent = true

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
end

-- Autocommand that sets up neovim coloerscheme
--vim.cmd([[
--    augroup color_scheme 
--    autocmd!
--    autocmd User PackerComplete colorscheme ]] .. colorscheme .. [[ 
--    augroup end
--]])
