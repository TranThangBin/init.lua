return {
	"nvim-telescope/telescope.nvim",

	branch = "0.1.x",

	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},

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
			{
				"<leader>tf",
				builtin.find_files,
				desc = "Telescope: [t]elescope [f]iles",
			},

			{
				"<leader>tg",
				builtin.git_files,
				desc = "Telescope: [t]elescope [g]it files",
			},

			{
				"<leader>tk",
				builtin.keymaps,
				desc = "Telescope: [t]elescope [k]eymaps",
			},

			{
				"<leader>lg",
				builtin.live_grep,
				desc = "Telescope: [l]ive [g]rep",
			},

			{
				"<leader>of",
				builtin.oldfiles,
				desc = "Telescope: [o]ld [f]iles",
			},

			{
				"<leader>rs",
				builtin.resume,
				desc = "Telescope: [r]e[s]ume",
			},
		}
	end,

	config = function(_, opts)
		local telescope = require("telescope")
		telescope.setup(opts)
		telescope.load_extension("fzf")
	end,
}
