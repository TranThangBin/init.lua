return {
	"ThePrimeagen/harpoon",

	branch = "harpoon2",

	dependencies = { "nvim-lua/plenary.nvim" },

	keys = function()
		local ui = require("harpoon").ui
		local list = require("harpoon"):list()

		local keys = {
			{
				"<leader>a",
				function()
					list:add()
				end,
			},

			{
				"<leader>m",
				function()
					ui:toggle_quick_menu(list)
				end,
			},

			{
				"<C-l>",
				function()
					list:next()
				end,
			},

			{
				"<C-h>",
				function()
					list:prev()
				end,
			},
		}

		for i = 1, 5 do
			table.insert(keys, {
				"<leader>" .. i,
				function()
					list:select(i)
				end,
			})
		end

		return keys
	end,
}
