require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

require("mason-lspconfig").setup({
	-- for lsp
	ensure_installed = {
		"tsserver",
		"eslint",
		"svelte",
		"tailwindcss",
		"jsonls",
		"bashls",
		"emmet_language_server",
		"omnisharp",
		"ltex",
		"lua_ls",
		"sqlls",
		"html",
		"gopls",
		"dockerls",
		"docker_compose_language_service",
	},
})

require("mason-null-ls").setup({
	-- for formatter
	ensure_installed = {
		"stylua",
		"prettierd",
		"goimports-reviser",
		"black",
		"clang-format",
	},
})
