vim.g.mapleader = " "

vim.keymap.set({ "s", "i" }, "jj", "<Esc>")

vim.keymap.set("x", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("x", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- x = visual, v = visual and select
vim.keymap.set({ "n", "x" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "x" }, "<leader>Y", '"+Y')
vim.keymap.set({ "n", "x" }, "<leader>dO", ":delete<CR>O<Esc>")
vim.keymap.set("x", "<leader>d", '"_d')
vim.keymap.set("x", "<leader>p", '"_dP')

vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

vim.keymap.set("n", "<leader><leader>", vim.cmd.so)

vim.keymap.set("n", "<leader>fe", function()
	local f = io.open(vim.api.nvim_buf_get_name(0))

	if f == nil then
		vim.cmd("Ex")
		return
	end

	io.close(f)

	vim.cmd("Ex|/" .. vim.fn.expand("%:t"))
end)

vim.keymap.set("n", "<leader>w", function()
	vim.wo.wrap = not vim.wo.wrap
end)
