return {
	"nvim-lua/plenary.nvim",
	{
		"nvim-treesitter/playground",
		dependencies = "nvim-treesitter/nvim-treesitter",
	},
	{
		"windwp/nvim-ts-autotag",
		dependencies = "nvim-treesitter/nvim-treesitter",
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{
		"mbbill/undotree",
		config = function()
			vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
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
}
