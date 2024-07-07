local M = {}

table.insert(M, "nvim-lua/plenary.nvim")

table.insert(M, "nvim-tree/nvim-web-devicons")

table.insert(M, "tpope/vim-obsession")

table.insert(M, {
	"numToStr/Comment.nvim",
	config = true,
})

table.insert(M, {
	"mbbill/undotree",
	keys = { { "<leader>u", "<cmd>UndotreeToggle<CR>" } },
})

table.insert(M, {
	"prichrd/netrw.nvim",
	dependencies = "nvim-tree/nvim-web-devicons",
	opts = {},
})

table.insert(M, {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	config = true,
})

table.insert(M, {
	"windwp/nvim-ts-autotag",
	dependencies = "nvim-treesitter/nvim-treesitter",
	config = true,
})

table.insert(M, {
	"kylechui/nvim-surround",
	version = "*",
	event = "VeryLazy",
	config = true,
})

table.insert(M, {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = { default_file_explorer = false },
	keys = { { "<leader>-", "<cmd>Oil<CR>" } },
})

table.insert(M, {
	"nvim-treesitter/nvim-treesitter-context",
	dependencies = "nvim-treesitter/nvim-treesitter",
	opts = { enable = false },
	lazy = false,
	keys = { { "<leader>ct", "<cmd>TSContextToggle<CR>" } },
})

table.insert(M, {
	"tpope/vim-fugitive",
	cmd = { "G", "Git" },
	keys = {
		{ "<leader>gs", "<cmd>Git<CR>" },
		{ "gh", "<cmd>diffget //2<CR>" },
		{ "gl", "<cmd>diffget //3<CR>" },
	},
})

table.insert(M, {
	"nvim-telescope/telescope-fzf-native.nvim",
	dependencies = "nvim-telescope/telescope.nvim",
	cond = vim.fn.executable("make") == 1,
	build = "make",
	config = function()
		require("telescope._extensions").load("fzf")
	end,
})

table.insert(M, {
	"folke/todo-comments.nvim",
	dependencies = "nvim-lua/plenary.nvim",
	lazy = false,
	config = true,
	keys = function()
		local jump = require("todo-comments.jump")
		return {
			{ "<leader>ttf", "<cmd>TodoTelescope<CR>" },
			{ "<leader>txx", "<cmd>TodoTrouble<CR>" },
			{ "]t", jump.next },
			{ "[t", jump.prev },
		}
	end,
})

return M
