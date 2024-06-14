return {
	"folke/zen-mode.nvim",

	opts = function()
		local number = vim.wo.number
		local rnu = vim.wo.rnu
		local colorcolumn = vim.opt.colorcolumn

		return {
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
				tmux = { enabled = true },
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
				if vim.bo.filetype ~= "netrw" then
					vim.wo.number = number
					vim.wo.rnu = rnu
					vim.opt.colorcolumn = colorcolumn
				end
			end,
		}
	end,

	keys = function()
		local zen_mode = require("zen-mode")

		return {
			{
				"<leader>zz",
				zen_mode.toggle,
			},

			{
				"<leader>zZ",
				function()
					zen_mode.toggle({
						window = {
							width = 85,
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
				end,
			},
		}
	end,

	config = true,
}
