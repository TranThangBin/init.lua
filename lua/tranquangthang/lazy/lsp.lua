return {
	"VonHeikemen/lsp-zero.nvim",

	branch = "v3.x",

	dependencies = {
		"neovim/nvim-lspconfig",
		"williamboman/mason-lspconfig.nvim",
		"williamboman/mason.nvim",
	},

	config = function()
		local lsp_zero = require("lsp-zero")

		lsp_zero.preset("recommended")

		require("mason").setup({
			ui = {
				border = "single",

				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		require("mason-lspconfig").setup({
			handlers = {
				lsp_zero.default_setup,
				eslint = lsp_zero.noop,
				ltex = lsp_zero.noop,
				lua_ls = function()
					local lua_opts = lsp_zero.nvim_lua_ls()
					require("lspconfig").lua_ls.setup(lua_opts)
				end,
			},
		})

		vim.diagnostic.config({
			virtual_text = false,
			severity_sort = true,
			float = {
				style = "minimal",
				border = "rounded",
				source = true,
				header = "",
				prefix = "",
			},
		})

		lsp_zero.set_sign_icons({
			error = "✘",
			warn = "▲",
			hint = "⚑",
			info = "»",
		})

		lsp_zero.setup()
	end,
}
