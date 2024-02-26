local ok, mason = pcall(require, "mason")

if ok then
	mason.setup({
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

	require("mason-null-ls").setup({
		-- for formatter
		ensure_installed = {
			"stylua",
			"black",
			"clang-format",
			"prettierd",
		},
	})
end
