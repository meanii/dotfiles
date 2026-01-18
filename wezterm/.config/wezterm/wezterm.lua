local wezterm = require("wezterm")
local config = wezterm.config_builder()
local mux = wezterm.mux

-- Set initial size (adjust these values to your preference)
config.initial_cols = 120
config.initial_rows = 35

-- Keep your existing configuration below
config.font_size = 12
-- config.font = wezterm.font("JetBrainsMono NF")
-- config.font = wezterm.font("JetBrains Mono")
wezterm.font("FiraCode Nerd Font", {weight="Regular", stretch="Normal", style="Normal"})

config.automatically_reload_config = true
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.adjust_window_size_when_changing_font_size = false
config.harfbuzz_features = { "calt=0" }
config.max_fps = 120
config.animation_fps = 120
config.front_end = "WebGpu"
config.prefer_egl = true
config.window_close_confirmation = "NeverPrompt"
config.window_background_opacity = 1
config.macos_window_background_blur = 12
config.audible_bell = "Disabled"

config.window_padding = {
    left = 18,
    right = 15,
    top = 20,
    bottom = 5,
}

-- Key bindings delete word
config.keys = {
    {
        key = "LeftArrow",
        mods = "OPT",
        action = wezterm.action({ SendString = "\x1bb" }),
    },
    {
        key = "RightArrow",
        mods = "OPT",
        action = wezterm.action({ SendString = "\x1bf" }),
    },
}

config.color_scheme = "rose-pine"
config.colors = {
    background = "#000",
    cursor_bg = "#9B96B5",
    cursor_fg = "#1a1a1e",
    cursor_border = "#9B96B5",
}

return config
