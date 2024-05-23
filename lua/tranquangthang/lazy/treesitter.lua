return {
	"nvim-treesitter/nvim-treesitter",

	build = function()
		require("nvim-treesitter.install").update({ with_sync = true })()
	end,

	opts = {
		ensure_installed = {
			"javascript",
			"typescript",
			"c",
			"lua",
			"vim",
			"vimdoc",
			"query",
		},
		sync_install = false,
		auto_install = true,
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
	},

	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
