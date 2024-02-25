local ok, telescope = pcall(require, "telescope")

if ok then
	local builtin = require("telescope.builtin")
	local trouble = require("trouble.providers.telescope")

	local mappings = {}

	if trouble ~= nil then
		mappings = {
			i = { ["<C-t>"] = trouble.open_with_trouble },
			n = { ["<C-t>"] = trouble.open_with_trouble },
		}
	end

	vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
	vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
	vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
	vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
	vim.keymap.set("n", "<leader>gf", builtin.git_files, {})

	telescope.setup({
		defaults = {
			mappings = mappings,
		},
	})
end
