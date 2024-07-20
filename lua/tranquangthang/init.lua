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

vim.api.nvim_create_autocmd("BufEnter", {
	group = my_group,
	pattern = "*",
	callback = function(args)
		local bufnr = args.buf
		local ft = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
		if ft == "fugitive" then
			vim.keymap.set("n", "A", "<cmd>Git add .<CR>", { buffer = bufnr })
			vim.keymap.set("n", "S", "<cmd>Git add -u<CR>", { buffer = bufnr })
		end
	end,
})
