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
				desc = "Harpoon: [a]dd the current buffer to the harpoon list",
			},

			{
				"<leader>m",
				function()
					ui:toggle_quick_menu(list)
				end,
				desc = "Harpoon: toggle harpoon [m]enu",
			},

			{
				"<leader>j",
				function()
					list:next()
				end,
				desc = "Harpoon: jump to the next buffer in the harpoon list",
			},

			{
				"<leader>k",
				function()
					list:prev()
				end,
				desc = "Harpoon: jump to the previous buffer in the harpoon list",
			},
		}

		for i = 1, 5 do
			table.insert(keys, {
				"<leader>" .. i,
				function()
					list:select(i)
				end,
				desc = "Harpoon: jump to the ["
					.. i
					.. "] buffer in the harpoon list",
			})
		end

		return keys
	end,
}
