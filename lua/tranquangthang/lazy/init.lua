return {
	"nvim-lua/plenary.nvim",

	{
		"windwp/nvim-ts-autotag",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = true,
	},

	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = function()
			require("treesitter-context").setup({ enable = false })
			vim.keymap.set("n", "<leader>ct", "<cmd>TSContextToggle<CR>")
		end,
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},

	{
		"mbbill/undotree",
		config = function()
			vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<CR>")
		end,
	},

	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
			vim.keymap.set("n", "gh", "<cmd>diffget //2<CR>")
			vim.keymap.set("n", "gl", "<cmd>diffget //3<CR>")
		end,
	},

	{
		"folke/todo-comments.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"folke/trouble.nvim",
		},
		config = function()
			require("todo-comments").setup()
			vim.keymap.set("n", "ttf", "<cmd>TodoTelescope<CR>")
			vim.keymap.set("n", "txx", "<cmd>TodoTrouble<CR>")
		end,
	},
}
