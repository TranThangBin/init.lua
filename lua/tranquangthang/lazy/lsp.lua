return {
	"VonHeikemen/lsp-zero.nvim",

	branch = "v3.x",

	dependencies = {
		"neovim/nvim-lspconfig",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"b0o/schemastore.nvim",
	},

	config = function()
		require("lspconfig.ui.windows").default_options.border = "rounded"

		local lsp_zero = require("lsp-zero")
		local lspconfig = require("lspconfig")
		local schemastore = require("schemastore")

		require("mason").setup({
			ui = {
				border = "rounded",

				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		require("mason-lspconfig").setup({
			ensure_installed = { "lua_ls" },

			handlers = {
				lsp_zero.default_setup,

				lua_ls = function()
					local lua_opts = lsp_zero.nvim_lua_ls()
					lspconfig.lua_ls.setup(lua_opts)
				end,

				jsonls = function()
					lspconfig.jsonls.setup({
						settings = {
							json = {
								schemas = schemastore.json.schemas(),
								validate = { enable = true },
							},
						},
					})
				end,

				yamlls = function()
					lspconfig.yamlls.setup({
						yaml = {
							schemas = schemastore.yaml.schemas(),
							schemaStore = {
								enable = false,
								url = "",
							},
						},
					})
				end,
			},
		})

		vim.diagnostic.config({
			virtual_text = true,
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
	end,
}
