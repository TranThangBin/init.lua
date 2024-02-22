local telescope = require("telescope")

if telescope ~= nil then
	local builtin = require("telescope.builtin")
	local trouble = require("trouble.providers.telescope")

	local mappings = {}

	if trouble ~= nil then
		mappings = {
			i = { ["<C-t>"] = trouble.open_with_trouble },
			n = { ["<C-t>"] = trouble.open_with_trouble },
		}
	end

	vim.keymap.set("n", "<leader>tf", builtin.find_files, {})
	vim.keymap.set("n", "<leader>tg", builtin.git_files, {})

	telescope.setup({
		defaults = {
			mappings = mappings,
		},
	})
end
