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
	ensure_installed = {
		"tsserver",
		"eslint",
		"svelte",
		"tailwindcss",
		"jsonls",
		"bashls",
		"clangd",
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
	-- ensure installed with mason-null-ls
	ensure_installed = {
		"stylua",
		"prettierd",
		"csharpier",
		"goimports-reviser",
		"black",
	},
})
