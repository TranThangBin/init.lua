local number = vim.wo.number
local rnu = vim.wo.rnu
local colorcolumn = vim.opt.colorcolumn

return {
	"folke/zen-mode.nvim",

	opts = {
		window = {
			backdrop = 0.95,
			width = 90,
			height = 1,
			options = {},
		},
		plugins = {
			options = {
				enabled = true,
				ruler = false,
				laststatus = 0,
			},
			twilight = { enabled = true },
			gitsigns = { enabled = false },
			tmux = { enabled = false },
			kitty = {
				enabled = false,
				font = "+4",
			},
			alacritty = {
				enabled = false,
				font = "14",
			},
			wezterm = {
				enabled = false,
				font = "+4",
			},
		},
		on_close = function()
			vim.wo.number = number
			vim.wo.rnu = rnu
			vim.opt.colorcolumn = colorcolumn
		end,
	},

	config = function()
		local zen_mode_toggle = require("zen-mode").toggle

		vim.keymap.set("n", "<leader>zz", zen_mode_toggle)
		vim.keymap.set("n", "<leader>zZ", function()
			zen_mode_toggle({
				window = {
					width = 80,
					options = {
						signcolumn = "no",
						number = false,
						relativenumber = false,
						cursorline = false,
						cursorcolumn = false,
						foldcolumn = "0",
						list = false,
					},
				},
			})
		end)
	end,
}
