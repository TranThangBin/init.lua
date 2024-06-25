return {
	"nvim-lua/plenary.nvim",

	"nvim-tree/nvim-web-devicons",

	{
		"numToStr/Comment.nvim",
		config = true,
	},

	{
		"mbbill/undotree",
		keys = { { "<leader>u", "<cmd>UndotreeToggle<CR>" } },
	},

	{
		"prichrd/netrw.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {},
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},

	{
		"windwp/nvim-ts-autotag",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = true,
	},

	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = true,
	},

	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = { default_file_explorer = false },
		keys = { { "<leader>-", "<cmd>Oil<CR>" } },
	},

	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = "nvim-treesitter/nvim-treesitter",
		opts = { enable = false },
		lazy = false,
		keys = { { "<leader>ct", "<cmd>TSContextToggle<CR>" } },
	},

	{
		"tpope/vim-fugitive",
		cmd = { "G", "Git" },
		keys = {
			{ "<leader>gs", "<cmd>Git<CR>" },
			{ "gh", "<cmd>diffget //2<CR>" },
			{ "gl", "<cmd>diffget //3<CR>" },
		},
	},

	{
		"nvim-telescope/telescope-fzf-native.nvim",
		dependencies = "nvim-telescope/telescope.nvim",
		cond = vim.fn.executable("make") == 1,
		build = "make",
		config = function()
			require("telescope").load_extension("fzf")
		end,
	},

	{
		"folke/todo-comments.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"folke/trouble.nvim",
		},
		lazy = false,
		keys = function()
			local todo_jump = require("todo-comments.jump")

			return {
				{ "ttf", "<cmd>TodoTelescope<CR>" },
				{ "txx", "<cmd>TodoTrouble<CR>" },
				{ "]t", todo_jump.next },
				{ "[t", todo_jump.prev },
			}
		end,
		config = true,
	},
}
