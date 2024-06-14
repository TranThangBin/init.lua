require("tranquangthang.set")
require("tranquangthang.remap")

local my_group = vim.api.nvim_create_augroup("tranquangthang", {})

vim.api.nvim_create_autocmd("ColorScheme", {
	group = my_group,
	callback = function()
		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	end,
})

require("tranquangthang.lazy_init")
