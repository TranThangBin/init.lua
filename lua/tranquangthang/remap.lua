vim.g.mapleader = " "
vim.keymap.set("n", "<leader>fe", vim.cmd.Ex)

vim.keymap.set("n", "<leader>y", '"+y$')
vim.keymap.set("x", "<leader>y", '"+y')

vim.keymap.set("s", "jj", "<Esc>")
vim.keymap.set("i", "jj", "<Esc>")

vim.keymap.set("x", "<leader>p", '"_dP')

vim.keymap.set("n", "<leader>w", function()
	if vim.wo.wrap then
		vim.wo.wrap = false
	else
		vim.wo.wrap = true
	end
end)
