return {
	"gelguy/wilder.nvim",

	dependencies = { "nvim-tree/nvim-web-devicons" },

	opts = {
		modes = { ":", "/", "?" },
		next_key = "<Tab>",
		previous_key = "<S-Tab>",
		accept_key = "<Down>",
		reject_key = "<Up>",
		enable_cmdline_enter = 0,
	},

	config = function(_, opts)
		local wilder = require("wilder")

		wilder.setup(opts)

		wilder.set_option(
			"renderer",
			wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
				highlights = {
					border = "Normal",
				},
				border = "rounded",
				highlighter = wilder.basic_highlighter(),
				left = { " ", wilder.popupmenu_devicons() },
				min_width = "auto",
				min_height = "50%",
				reverse = 0,
			}))
		)
	end,
}