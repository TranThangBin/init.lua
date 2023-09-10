local wilder = require("wilder")

wilder.setup({
	modes = { ":", "/", "?" },
	next_key = "<Tab>",
	previous_key = "<S-Tab>",
	accept_key = "<Down>",
	reject_key = "<Up>",
	enable_cmdline_enter = 0,
})

wilder.set_option(
	"renderer",
	wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
		highlights = {
			border = "Normal", -- highlight to use for the border
		},
		-- 'single', 'double', 'rounded' or 'solid'
		-- can also be a list of 8 characters, see :h wilder#popupmenu_border_theme() for more details
		border = "rounded",
		highlighter = wilder.basic_highlighter(),
		min_width = "auto", -- minimum height of the popupmenu, can also be a number
		min_height = "50%", -- to set a fixed height, set max_height to the same value
		reverse = 0, -- if 1, shows the candidates from bottom to top
	}))
)
