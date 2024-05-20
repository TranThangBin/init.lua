return {
	"jay-babu/mason-null-ls.nvim",

	event = { "BufReadPre", "BufNewFile" },

	dependencies = {
		"williamboman/mason.nvim",
		"nvimtools/none-ls.nvim",
	},

	opts = function()
		return {
			ensure_installed = { "stylua" },
			handlers = {},
		}
	end,
}
