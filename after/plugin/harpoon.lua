local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
local maxFiles = 9

vim.keymap.set("n", "<leader>ha", mark.add_file)
vim.keymap.set("n", "<leader>hm", ui.toggle_quick_menu)

for i = 1, maxFiles do
	vim.keymap.set("n", "<leader>h" .. i, function()
		ui.nav_file(i)
	end)
end
