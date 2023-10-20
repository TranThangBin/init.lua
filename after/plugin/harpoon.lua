local ui = require("harpoon.ui")
local MAXFILES = 9

vim.keymap.set("n", "<leader>ha", require("harpoon.mark").add_file)
vim.keymap.set("n", "<leader>hm", ui.toggle_quick_menu)

for i = 1, MAXFILES do
	vim.keymap.set("n", "<leader>h" .. i, function()
		ui.nav_file(i)
	end)
end
