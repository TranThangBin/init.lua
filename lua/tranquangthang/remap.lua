vim.g.mapleader = " "

vim.keymap.set({ "s", "i" }, "jj", "<Esc>")

vim.keymap.set("x", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("x", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("x", "<C-d>", "<C-d>zz")
vim.keymap.set("x", "<C-u>", "<C-u>zz")

vim.keymap.set("x", "n", "nzzzv")
vim.keymap.set("x", "N", "Nzzzv")

-- x = visual, v = visual and select
vim.keymap.set({ "n", "x" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "x" }, "<leader>Y", '"+Y')

vim.keymap.set("x", "<leader>d", '"_d')
vim.keymap.set("x", "<leader>p", '"_dP')

vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

vim.keymap.set("n", "<leader><leader>", vim.cmd.so)

vim.keymap.set("n", "<leader>w", ":set wrap!<CR>")

vim.keymap.set("n", "<leader>nb", vim.cmd.enew)

vim.keymap.set("n", "<leader>fe", function()
	local fileName = vim.fn.expand("%:t")

	local filePattern = fileName
		:gsub("%(", "\\%(")
		:gsub("%)", "\\%)")
		:gsub("%.", "\\%.")
		:gsub("%%", "\\%%")
		:gsub("%+", "\\%+")
		:gsub("%-", "\\%-")
		:gsub("%*", "\\%*")
		:gsub("%?", "\\%?")
		:gsub("%[", "\\%[")
		:gsub("%^", "\\%^")
		:gsub("%$", "\\%$")

	local last_search = vim.fn.getreg("/")

	vim.cmd("Ex|silent!/" .. filePattern)

	vim.fn.setreg("/", last_search)
end)
