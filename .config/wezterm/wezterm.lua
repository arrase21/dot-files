local wezterm = require("wezterm")

wezterm.on("update-right-status", function(window)
	window:set_right_status(window:active_workspace())
end)

-- A helper function for my fallback fonts
local function font_with_fallback(name, params)
	local names = { name, "Noto Color Emoji", "JetBrains Mono" }
	return wezterm.font_with_fallback(names, params)
end

local fonts = {
	"JetBrainsMono Nerd Font",
	"VictorMono Nerd Font",
}

local font = fonts[2]

return {
	-- General configuration
	audible_bell = "Disabled",
	window_close_confirmation = "NeverPrompt",
	use_fancy_tab_bar = false,
	enable_tab_bar = false,

	window_padding = {
		left = 2,
		right = 2,
		top = 2,
		bottom = 2,
	},

	-- Font and color scheme
	font = font_with_fallback(font, { weight = "DemiBold" }),
	font_rules = {
		-- Select a fancy italic font for italic text
		{
			italic = true,
			font = font_with_fallback(font, { weight = "DemiBold", italic = true }),
		},

		-- Similarly, a fancy bold+italic font
		{
			italic = true,
			intensity = "Bold",
			font = font_with_fallback(font, { weight = "ExtraBold", italic = true }),
		},
	},
	font_size = 12,
	use_resize_increments = true,
	line_height = 1.0,
	-- color_scheme = "Eqie6 (terminal.sexy)",
	window_background_opacity = 0.9,
	color_scheme = "Dracula (Official)",
	tab_bar_at_bottom = true,
	window_decorations = "RESIZE",

	default_prog = { "tmux", "new-session" },

	disable_default_key_bindings = true,
}
