local wezterm = require("wezterm")
local config = wezterm.config_builder()
local mux = wezterm.mux

-- New startup event to center the window
wezterm.on("gui-startup", function(cmd)
    local tab, pane, window = mux.spawn_window(cmd or {})
    local gui_window = window:gui_window()
    
    -- Get screen dimensions
    local screen = gui_window:screen()
    local screen_width = screen.working_right - screen.working_left
    local screen_height = screen.working_bottom - screen.working_top
    
    -- Calculate centered position with margins
    local margin = 80  -- Adjust this value to change margin size
    local x = math.max(screen.working_left + margin, 0)
    local y = math.max(screen.working_top + margin, 0)
    
    gui_window:set_position(x, y)
end)

-- Set initial size (adjust these values to your preference)
config.initial_cols = 120
config.initial_rows = 35

-- Keep your existing configuration below
config.font_size = 18
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
