local nvim_tree = require("nvim-tree")

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
-- nvim_tree.setup()

-- OR setup with some options
-- nvim_tree.setup({
-- 	    sort_by = "case_sensitive",
-- 	view = {
-- 		width = 30,
-- 	},
-- 	renderer = {
-- 		group_empty = true,
-- 	},
-- 	filters = {
-- 		dotfiles = true,
-- 	},
-- })

-- pass to setup along with your other options
nvim_tree.setup({
	---
	on_attach = function(bufnr)
		local api = require("nvim-tree.api")

		local function opts(desc)
			return {
				desc = "nvim-tree: " .. desc,
				buffer = bufnr,
				noremap = true,
				silent = true,
				nowait = true,
			}
		end

		-- default mappings
		api.config.mappings.default_on_attach(bufnr)

		-- custom mappings
		vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts("Up"))
		vim.keymap.set("n", "g?", api.tree.toggle_help, opts("Help"))
	end,
	---
	sort_by = "case_sensitive",
	view = {
		width = 30,
	},
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = true,
		custom = { "node_modules" },
	},
})

vim.keymap.set("n", "<leader>tt", vim.cmd.NvimTreeToggle)
