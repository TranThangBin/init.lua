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
		require("lspconfig.ui.windows").default_options.border = "single"

		local lsp_zero = require("lsp-zero")
		local lspconfig = require("lspconfig")
		local schemastore = require("schemastore")
		local ok, lazydev = pcall(require, "lazydev.config")

		local no_lazydev = not ok
			or not lazydev.is_enabled(vim.uv.cwd() --[[ @as string ]])

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

		local lspconfig_handler = {
			lsp_zero.default_setup,

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
		}

		if no_lazydev then
			lspconfig_handler.lua_ls = function()
				lspconfig.setup(lsp_zero.nvim_lua_ls())
			end
		end

		require("mason-lspconfig").setup({
			ensure_installed = { "lua_ls" },

			handlers = lspconfig_handler,
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
