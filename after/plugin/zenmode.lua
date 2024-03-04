local zenmode = require("zen-mode")

local number = vim.wo.number
local rnu = vim.wo.rnu
local colorcolumn = vim.opt.colorcolumn

vim.keymap.set("n", "<leader>zz", function()
	zenmode.setup({
		window = {
			width = 90,
			options = {},
		},
	})
	zenmode.toggle()
	vim.wo.number = number
	vim.wo.rnu = rnu
	vim.opt.colorcolumn = colorcolumn
end)

vim.keymap.set("n", "<leader>zZ", function()
	zenmode.setup({
		window = {
			width = 80,
			options = {},
		},
	})
	zenmode.toggle()
	vim.wo.number = not number
	vim.wo.rnu = not rnu
	vim.opt.colorcolumn = "0"
end)
