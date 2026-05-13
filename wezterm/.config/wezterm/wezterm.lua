local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.initial_cols = 120
config.initial_rows = 28

config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 12

config.max_fps = 120
config.animation_fps = 120

-- Cursor: block, no blink, smooth easing (matching kitty feel)
config.default_cursor_style = "SteadyBlock"
config.cursor_blink_rate = 0
config.cursor_blink_ease_in = "EaseIn"
config.cursor_blink_ease_out = "EaseOut"

-- Smooth visual bell fade (kitty-like feedback cue)
config.visual_bell = {
	fade_in_function = "EaseIn",
	fade_in_duration_ms = 75,
	fade_out_function = "EaseOut",
	fade_out_duration_ms = 100,
}

-- Pastel pink palette matching kitty/nvim theme
config.colors = {
	foreground = "#F4EDEA",
	background = "#171114",

	cursor_border = "#FFB7B2",
	cursor_bg = "#FFB7B2",
	cursor_fg = "#1E1B22",

	selection_bg = "#493B47",
	selection_fg = "#F4EDEA",

	visual_bell = "#FF8FA3",

	ansi = {
		"#2A2734", -- black
		"#F28FAD", -- red
		"#A6D189", -- green
		"#F6C177", -- yellow
		"#96CDFB", -- blue
		"#FFB7B2", -- magenta
		"#89DCEB", -- cyan
		"#E0DEF4", -- white
	},
	brights = {
		"#7A738C", -- bright black
		"#F8B0C4", -- bright red
		"#B5E890", -- bright green
		"#F9D092", -- bright yellow
		"#B5DFFD", -- bright blue
		"#FF8FA3", -- bright magenta
		"#A6E3F4", -- bright cyan
		"#F4EDEA", -- bright white
	},

	tab_bar = {
		background = "#171114",
		active_tab = {
			bg_color = "#FFB7B2",
			fg_color = "#1E1B22",
		},
		inactive_tab = {
			bg_color = "#2A2734",
			fg_color = "#7A738C",
		},
		inactive_tab_hover = {
			bg_color = "#493B47",
			fg_color = "#F4EDEA",
		},
		new_tab = {
			bg_color = "#171114",
			fg_color = "#7A738C",
		},
		new_tab_hover = {
			bg_color = "#493B47",
			fg_color = "#F4EDEA",
		},
	},
}

-- Remove title bar (keeps resize border)
config.window_decorations = "RESIZE"

-- Hide tab bar when only one tab open
config.hide_tab_bar_if_only_one_tab = true

-- Tab bar background
config.window_frame = {
	inactive_titlebar_bg = "#171114",
	active_titlebar_bg = "#171114",
}

-- Transparency with strong blur (macOS)
config.window_background_opacity = 0.85
config.macos_window_background_blur = 80

config.font_size = 13.5

return config
