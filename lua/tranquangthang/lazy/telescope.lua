return {
	"nvim-telescope/telescope.nvim",

	branch = "0.1.x",

	dependencies = "nvim-lua/plenary.nvim",

	opts = function()
		return {
			defaults = {
				mappings = {
					n = { q = require("telescope.actions").close },
				},
			},
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
			},
		}
	end,

	keys = function()
		local builtin = require("telescope.builtin")
		return {
			{ "<leader>tf", builtin.find_files },
			{ "<leader>tg", builtin.git_files },
			{ "<leader>tk", builtin.keymaps },
			{ "<leader>bf", builtin.buffers },
			{ "<leader>lg", builtin.live_grep },
			{ "<leader>of", builtin.oldfiles },
			{ "<leader>rs", builtin.resume },
		}
	end,

	config = true,
}
