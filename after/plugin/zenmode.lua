local zenmode = require("zen-mode")

local colorcolumn = vim.opt.colorcolumn

vim.keymap.set("n", "<leader>zz", function()
	zenmode.setup({
		window = {
			width = 90,
			options = {},
		},
	})
	zenmode.toggle()
	vim.wo.wrap = false
	vim.wo.number = true
	vim.wo.rnu = true
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
	vim.wo.wrap = false
	vim.wo.number = false
	vim.wo.rnu = false
	vim.opt.colorcolumn = "0"
end)
