local wezterm = require("wezterm")
local act = wezterm.action

local config = {
	color_scheme = "tokyonight-storm",
	window_background_opacity = 0.8,
}

config.keys = {
	{ key = "LeftArrow", mods = "OPT", action = act.SendString("\x1bb") }, -- backward-word
	{ key = "RightArrow", mods = "OPT", action = act.SendString("\x1bf") }, -- forward-word
	{ key = "LeftArrow", mods = "CMD", action = act.SendString("\x01") }, -- beginning-of-line
	{ key = "RightArrow", mods = "CMD", action = act.SendString("\x05") }, -- end-of-line
}

return config
