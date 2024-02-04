local function toggle_wrap()
	vim.wo.wrap = not vim.wo.wrap
end

vim.g.mapleader = " "

vim.keymap.set("n", "<leader>fe", vim.cmd.Ex)

vim.keymap.set({ "s", "i" }, "jj", "<Esc>")

vim.keymap.set("x", "<leader>p", '"_dP')

vim.keymap.set("n", "<leader>w", toggle_wrap)
