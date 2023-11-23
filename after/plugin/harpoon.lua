local ui = require("harpoon.ui")
local term = require("harpoon.term")
local MAXFILES = 5

require("harpoon").setup({
	menu = {
		width = vim.api.nvim_win_get_width(0) - 4,
	},
})

vim.keymap.set("n", "<leader>ha", require("harpoon.mark").add_file)
vim.keymap.set("n", "<leader>hm", ui.toggle_quick_menu)
vim.keymap.set("n", "<leader>hj", ui.nav_next)
vim.keymap.set("n", "<leader>hk", ui.nav_prev)

for i = 1, MAXFILES do
	vim.keymap.set("n", "<leader>h" .. i, function()
		ui.nav_file(i)
	end)
	vim.keymap.set("n", "<leader>t" .. i, function()
		term.gotoTerminal(i)
	end)
end
