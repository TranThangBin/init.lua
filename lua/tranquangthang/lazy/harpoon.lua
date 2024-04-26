return {
	"ThePrimeagen/harpoon",

	dependencies = { "nvim-lua/plenary.nvim" },

	config = function()
		local ui = require("harpoon.ui")
		local term = require("harpoon.term")
		local mark = require("harpoon.mark")

		vim.keymap.set("n", "<leader>ha", mark.add_file)
		vim.keymap.set("n", "<leader>hm", ui.toggle_quick_menu)
		vim.keymap.set("n", "<leader>j", ui.nav_next)
		vim.keymap.set("n", "<leader>k", ui.nav_prev)

		for i = 1, 5 do
			vim.keymap.set("n", "<leader>h" .. i, function()
				ui.nav_file(i)
			end)
			vim.keymap.set("n", "<leader>t" .. i, function()
				term.gotoTerminal(i)
			end)
		end
	end,
}
