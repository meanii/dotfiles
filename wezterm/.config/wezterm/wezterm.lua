local wezterm = require("wezterm")

local config = {
	-- Appearance
	color_scheme = "Catppuccin Mocha",
	font = wezterm.font("JetBrains Mono"),
	font_size = 16.0,
	enable_tab_bar = false,

	-- Background Customization
	window_background_image = wezterm.config_dir .. "/backgrounds/blue-chains.png",
	window_background_image_hsb = {
		brightness = 0.05, -- Slightly brighter for better visibility
		hue = 1.0,
		saturation = 0.5,
	},
	window_background_opacity = 0.9,
	macos_window_background_blur = 30,

	-- Window Properties
	initial_rows = 35, -- Adjust window height
	initial_cols = 120, -- Adjust window width
	window_decorations = "RESIZE",
	adjust_window_size_when_changing_font_size = false,

	-- Key Bindings
	keys = {
		-- Toggle Fullscreen
		{
			key = "f",
			mods = "CTRL",
			action = wezterm.action.ToggleFullScreen,
		},
		-- Clear Scrollback
		{
			key = "L",
			mods = "CTRL",
			action = wezterm.action.ClearScrollback("ScrollbackAndViewport"),
		},
		-- Navigation with Option Key
		{ key = "LeftArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bb" }) },
		{ key = "RightArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bf" }) },
		{ key = "Home", mods = "OPT", action = wezterm.action({ SendString = "\x01" }) },
		{ key = "End", mods = "OPT", action = wezterm.action({ SendString = "\x05" }) },
	},

	-- Mouse Bindings
	mouse_bindings = {
		-- Ctrl-click to open link
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = wezterm.action.OpenLinkAtMouseCursor,
		},
	},

	-- Center Window on Launch (macOS/Linux)
	window_padding = {
		left = 10,
		right = 10,
		top = 10,
		bottom = 10,
	},
}

-- Center window for platforms supporting it
if wezterm.target_triple == "x86_64-apple-darwin" or wezterm.target_triple:find("linux") then
	config.initial_position = { x = "center", y = "center" }
end

return config
