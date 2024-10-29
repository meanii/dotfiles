local wezterm = require("wezterm")

local config = {
	-- color_scheme = 'termnial.sexy',
	color_scheme = "Catppuccin Mocha",
	enable_tab_bar = false,
	font_size = 16.0,
	font = wezterm.font("JetBrains Mono"),
	-- macos_window_background_blur = 40,
	macos_window_background_blur = 30,

	window_background_image = "/Users/anil/.config/wezterm/backgrounds/blue-chains.png",
	window_background_image_hsb = {
		brightness = 0.01,
		hue = 1.0,
		saturation = 0.5,
	},
	window_background_opacity = 0.92,
	-- window_background_opacity = 1.0,
	-- window_background_opacity = 0.78,
	-- window_background_opacity = 0.20,
	window_decorations = "RESIZE",
	keys = {
		{
			key = "f",
			mods = "CTRL",
			action = wezterm.action.ToggleFullScreen,
		},
		{
			key = "L",
			mods = "CTRL",
			action = wezterm.action.ClearScrollback("ScrollbackAndViewport"),
		},
		-- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
		{ key = "LeftArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bb" }) },
		-- Make Option-Right equivalent to Alt-f; forward-word
		{ key = "RightArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bf" }) },
		-- Make Option-Home equivalent to Ctrl-A; move to start of line
		{ key = "Home", mods = "OPT", action = wezterm.action({ SendString = "\x01" }) },
		-- Make Option-End equivalent to Ctrl-E; move to end of line
		{ key = "End", mods = "OPT", action = wezterm.action({ SendString = "\x05" }) },
	},
	mouse_bindings = {
		-- Ctrl-click will open the link under the mouse cursor
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = wezterm.action.OpenLinkAtMouseCursor,
		},
	},
}

return config
