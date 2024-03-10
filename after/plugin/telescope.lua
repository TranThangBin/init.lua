local ok, telescope, trouble

ok, telescope = pcall(require, "telescope")

if ok then
	local builtin = require("telescope.builtin")
	ok, trouble = pcall(require, "trouble.providers.telescope")

	local normalMapping = {
		q = require("telescope.actions").close,
	}
	local insertMapping = {}

	local mappings = {
		n = normalMapping,
		i = insertMapping,
	}

	if ok then
		normalMapping["<C-t>"] = trouble.open_with_trouble
		insertMapping["<C-t>"] = trouble.open_with_trouble
	end

	vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
	vim.keymap.set("n", "<leader>fg", builtin.git_files, {})
	vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
	vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
	vim.keymap.set("n", "<leader>lg", builtin.live_grep, {})
	vim.keymap.set("n", "<leader>of", builtin.oldfiles, {})

	telescope.setup({
		defaults = {
			mappings = mappings,
		},
	})
end
