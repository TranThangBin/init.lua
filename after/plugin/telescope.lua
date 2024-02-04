local telescope = require("telescope")
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local trouble = require("trouble.providers.telescope")

vim.keymap.set("n", "<leader>tf", builtin.find_files, {})
vim.keymap.set("n", "<leader>tg", builtin.git_files, {})

telescope.setup({
	defaults = {
		mappings = {
			i = { ["<C-t>"] = trouble.open_with_trouble },
			n = { ["<C-t>"] = trouble.open_with_trouble },
		},
	},
})
