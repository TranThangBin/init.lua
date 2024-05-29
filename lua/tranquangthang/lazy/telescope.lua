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

		vim.keymap.set("n", "<leader>tf", builtin.find_files, {})
		vim.keymap.set("n", "<leader>tg", builtin.git_files, {})
		vim.keymap.set("n", "<leader>tb", builtin.buffers, {})
		vim.keymap.set("n", "<leader>tk", builtin.keymaps, {})
		vim.keymap.set("n", "<leader>lg", builtin.live_grep, {})
		vim.keymap.set("n", "<leader>of", builtin.oldfiles, {})
		vim.keymap.set("n", "<leader>rs", builtin.resume, {})

		require("telescope").setup(opts)
	end,
}
