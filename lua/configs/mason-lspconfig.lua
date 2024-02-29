local mason_lspconfig = require("mason-lspconfig")

return {
	ensure_installed = function()
		vim.api.nvim_create_user_command("SetupLsp", function()
			mason_lspconfig.setup({
				-- for lsp
				ensure_installed = {
					"tsserver",
					"pyright",
					"cmake",
					"eslint",
					"svelte",
					"tailwindcss",
					"clangd",
					"jsonls",
					"bashls",
					"emmet_language_server",
					"omnisharp",
					"ltex",
					"lua_ls",
					"html",
					"gopls",
					"dockerls",
					"docker_compose_language_service",
				},
			})
		end, {})
	end,

	setup = function()
		local lsp_zero = require("configs.lsp-zero").lsp_zero
		local lsp_config = require("lspconfig")

		mason_lspconfig.setup({
			handlers = {
				lsp_zero.default_setup,
				eslint = lsp_zero.noop,
				lua_ls = function()
					local lua_opts = lsp_zero.nvim_lua_ls()
					lsp_config.lua_ls.setup(lua_opts)
				end,
			},
		})
	end,
}
