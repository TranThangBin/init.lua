return {
	"jay-babu/mason-null-ls.nvim",

	event = { "BufReadPre", "BufNewFile" },

	dependencies = {
		"williamboman/mason.nvim",
		"nvimtools/none-ls.nvim",
	},

	opts = {
		ensure_installed = { "stylua" },
		handlers = {},
	},

	config = function(_, opts)
		require("null-ls").setup()
		require("mason-null-ls").setup(opts)
	end,
}
