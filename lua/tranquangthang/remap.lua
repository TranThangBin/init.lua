vim.g.mapleader = " "

vim.keymap.set({ "s", "i" }, "jj", "<Esc>")
vim.keymap.set({ "s", "i" }, "jk", "j")

vim.keymap.set("x", "J", ":m '>+1<CR>gv=gv", { desc = "General: move selected line downward" })
vim.keymap.set("x", "K", ":m '<-2<CR>gv=gv", { desc = "General: move selected line upward" })

vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- x = visual, v = visual and select
vim.keymap.set({ "n", "x" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "x" }, "<leader>Y", '"+Y')
vim.keymap.set("x", "<leader>d", '"_d')
vim.keymap.set("x", "<leader>p", '"_dP')

vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<A-k>", "<cmd>lprev<CR>zz")
vim.keymap.set("n", "<A-j>", "<cmd>lnext<CR>zz")

vim.keymap.set(
	"n",
	"<leader>rw",
	":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
	{ desc = "General: [r]eplace all instance of the [w]ord under the cursor" }
)

vim.keymap.set("n", "<leader><leader>", "<cmd>so<CR>")

-- nice
vim.keymap.set("n", "<leader>e", function()
	local file_pattern = "^" .. "\\V" .. vim.fn.expand("%:t") .. "\\V" .. [[\(@|*\)\?\>]]

	local last_search = vim.fn.getreg("/")

	vim.cmd("Ex|silent!/" .. file_pattern)

	vim.fn.setreg("/", last_search)
end, { desc = "General: [e]xplore and set the cursor to the file you exit from" })
