require("tranquangthang.set")
require("tranquangthang.remap")
require("tranquangthang.lazy_init")

local my_group = vim.api.nvim_create_augroup("tranquangthang", {})

vim.api.nvim_create_autocmd("BufWritePre", {
	group = my_group,
	pattern = "*",
	callback = function()
		local pos = vim.fn.getpos(".")
		vim.cmd("%s/\\s\\+$//e")
		vim.fn.setpos(".", pos)
	end,
})
