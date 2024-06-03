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
		}
	end,

	config = function(_, opts)
		local builtin = require("telescope.builtin")

		vim.keymap.set(
			"n",
			"<leader>tf",
			builtin.find_files,
			{ desc = "Telescope: [t]elescope [f]iles" }
		)
		vim.keymap.set(
			"n",
			"<leader>tg",
			builtin.git_files,
			{ desc = "Telescope: [t]elescope [g]it files" }
		)
		vim.keymap.set(
			"n",
			"<leader>tb",
			builtin.buffers,
			{ desc = "Telescope: [t]elescope [b]uffers" }
		)
		vim.keymap.set(
			"n",
			"<leader>tk",
			builtin.keymaps,
			{ desc = "Telescope: [t]elescope [k]eymaps" }
		)
		vim.keymap.set("n", "<leader>lg", builtin.live_grep, { desc = "Telescope: [l]ive [g]rep" })
		vim.keymap.set("n", "<leader>of", builtin.oldfiles, { desc = "Telescope: [o]ld [f]iles" })
		vim.keymap.set("n", "<leader>rs", builtin.resume, { desc = "Telescope: [r]e[s]ume" })

		require("telescope").setup(opts)
	end,
}
