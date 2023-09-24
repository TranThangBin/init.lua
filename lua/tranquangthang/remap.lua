vim.g.mapleader = " "
vim.keymap.set("n", "<leader>fe", vim.cmd.Ex)

vim.keymap.set("n", "<leader>y", '"+y$')
vim.keymap.set("x", "<leader>y", '"+y')

vim.keymap.set("s", "jj", "<Esc>")
vim.keymap.set("i", "jj", "<Esc>")

vim.keymap.set("x", "<leader>p", '"_dP')

vim.keymap.set("n", "<leader>w", function()
	vim.wo.wrap = not vim.wo.wrap
end)
