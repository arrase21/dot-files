
--[[ local wezterm = require 'wezterm'

return {
  font = wezterm.font('Comic Code Ligatures', { weight = 'Regular', italic = true }),
  harfbuzz_features = { 'calt=0', 'clig=0', 'liga=1' },

  color_scheme = "Dracula (official)",
} ]]

local wezterm = require("wezterm")

wezterm.on("update-right-status", function(window)
	window:set_right_status(window:active_workspace())
end)

-- A helper function for my fallback fonts

return {

  font = wezterm.font('JetBrainsMonoNl Nerd Font', { weight = 'DemiBold', italic = true }),
	-- General configuration
   bold_brightens_ansi_colors = true,
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
	font_size = 11.5,
	-- use_resize_increments = true,
	-- line_height = 1.0,
	color_scheme = "Neon",
    window_background_opacity = 0.88,
	}
