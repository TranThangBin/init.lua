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
		opts = { enable = false },
		keys = { { "<leader>ct", "<cmd>TSContextToggle<CR>" } },
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},

	{
		"mbbill/undotree",
		keys = { { "<leader>u", "<cmd>UndotreeToggle<CR>" } },
	},

	{
		"tpope/vim-fugitive",
		keys = {
			{ "<leader>gs", "<cmd>Git<CR>" },
			{ "gh", "<cmd>diffget //2<CR>" },
			{ "gl", "<cmd>diffget //3<CR>" },
		},
	},

	{
		"folke/todo-comments.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"folke/trouble.nvim",
		},
		keys = {
			{ "ttf", "<cmd>TodoTelescope<CR>" },
			{ "txx", "<cmd>TodoTrouble<CR>" },
		},
		config = true,
	},
}
