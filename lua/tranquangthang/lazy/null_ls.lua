return {
	"jay-babu/mason-null-ls.nvim",

	event = { "BufReadPre", "BufNewFile" },

	dependencies = {
		"williamboman/mason.nvim",
		{
			"nvimtools/none-ls.nvim",
			opts = { border = "rounded" },
			config = true,
		},
	},

	opts = function()
		local null_ls = require("null-ls")
		return {
			ensure_installed = { "stylua" },
			handlers = {
				prettierd = function()
					null_ls.register(
						null_ls.builtins.formatting.prettierd.with({
							disabled_filetypes = {
								"typescript",
								"javascript",
								"json",
							},
						})
					)
				end,

				templ = function()
					null_ls.register({
						method = null_ls.methods.FORMATTING,
						name = "templfmt",
						filetypes = { "templ" },
						generator = null_ls.formatter({
							command = "templ",
							args = { "fmt", "-stdout", "$FILENAME" },
						}),
					})
				end,
			},
		}
	end,
}
