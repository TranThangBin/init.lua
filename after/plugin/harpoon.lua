local ok, harpoon = pcall(require, "harpoon")

if ok then
	local ui = require("harpoon.ui")
	local term = require("harpoon.term")
	local mark = require("harpoon.mark")

	harpoon.setup()

	vim.keymap.set("n", "<leader>ha", mark.add_file)
	vim.keymap.set("n", "<leader>hm", ui.toggle_quick_menu)
	vim.keymap.set("n", "<leader>hj", ui.nav_next)
	vim.keymap.set("n", "<leader>hk", ui.nav_prev)

	for i = 1, 5 do
		vim.keymap.set("n", "<leader>h" .. i, function()
			ui.nav_file(i)
		end)
		vim.keymap.set("n", "<leader>t" .. i, function()
			term.gotoTerminal(i)
		end)
	end
end
