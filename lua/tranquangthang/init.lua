require("tranquangthang.remap")
require("tranquangthang.set")

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})
