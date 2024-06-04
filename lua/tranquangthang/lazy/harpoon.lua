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
		end, { desc = "Harpoon: [a]dd the current buffer to the harpoon list" })

		vim.keymap.set("n", "<leader>m", function()
			harpoon.ui:toggle_quick_menu(list)
		end, { desc = "Harpoon: toggle harpoon [m]enu" })

		vim.keymap.set("n", "<leader>j", function()
			list:next()
		end, { desc = "Harpoon: jump to the next buffer in the harpoon list" })

		vim.keymap.set(
			"n",
			"<leader>k",
			function()
				list:prev()
			end,
			{ desc = "Harpoon: jump to the previous buffer in the harpoon list" }
		)

		for i = 1, 5 do
			vim.keymap.set(
				"n",
				"<leader>" .. i,
				function()
					list:select(i)
				end,
				{
					desc = "Harpoon: jump to the ["
						.. i
						.. "] buffer in the harpoon list",
				}
			)
		end
	end,
}
