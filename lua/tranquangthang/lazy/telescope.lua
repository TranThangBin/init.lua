return {
	"nvim-telescope/telescope.nvim",

	branch = "0.1.x",

	dependencies = {
		"nvim-lua/plenary.nvim",
		"folke/trouble.nvim",
	},

	opts = function()
		local open_with_trouble = require("trouble.providers.telescope").open_with_trouble

		local normal_mapping = { q = require("telescope.actions").close }
		local insert_mapping = {}

		local mappings = {
			n = normal_mapping,
			i = insert_mapping,
		}

		normal_mapping["<C-t>"] = open_with_trouble
		insert_mapping["<C-t>"] = open_with_trouble

		return {
			defaults = {
				mappings = mappings,
			},
		}
	end,

	config = function(_, opts)
		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<leader>tf", builtin.find_files, {})
		vim.keymap.set("n", "<leader>tg", builtin.git_files, {})
		vim.keymap.set("n", "<leader>tb", builtin.buffers, {})
		vim.keymap.set("n", "<leader>th", builtin.help_tags, {})
		vim.keymap.set("n", "<leader>tk", builtin.keymaps, {})
		vim.keymap.set("n", "<leader>lg", builtin.live_grep, {})
		vim.keymap.set("n", "<leader>of", builtin.oldfiles, {})
		vim.keymap.set("n", "<leader>rs", builtin.resume, {})

		require("telescope").setup(opts)
	end,
}
