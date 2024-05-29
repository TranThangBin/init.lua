return {
	"ThePrimeagen/harpoon",

	branch = "harpoon2",

	dependencies = { "nvim-lua/plenary.nvim" },

	config = function()
		local harpoon = require("harpoon")
		local list = harpoon:list()

		harpoon:setup()

		vim.keymap.set("n", "<leader>a", function()
			list:add()
		end)

		vim.keymap.set("n", "<leader>m", function()
			harpoon.ui:toggle_quick_menu(list)
		end)

		vim.keymap.set("n", "<leader>j", function()
			list:next()
		end)

		vim.keymap.set("n", "<leader>k", function()
			list:prev()
		end)

		for i = 1, 5 do
			vim.keymap.set("n", "<leader>" .. i, function()
				list:select(i)
			end)
		end
	end,
}
