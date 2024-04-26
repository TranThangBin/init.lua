return {
	"nvim-telescope/telescope.nvim",

	branch = "0.1.x",

	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "folke/trouble.nvim" },
	},

	config = function()
		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
		vim.keymap.set("n", "<leader>fg", builtin.git_files, {})
		vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
		vim.keymap.set("n", "<leader>lg", builtin.live_grep, {})
		vim.keymap.set("n", "<leader>of", builtin.oldfiles, {})
		vim.keymap.set("n", "<leader>rs", builtin.resume, {})

		vim.keymap.set("n", "<leader>ps", function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end)

		require("telescope").setup({
			defaults = {
				mappings = {
					["n"] = {
						["q"] = require("telescope.actions").close,
						["<C-t>"] = require("trouble.providers.telescope"),
					},
					["i"] = {
						["<C-t>"] = require("trouble.providers.telescope"),
					},
				},
			},
		})
	end,
}
