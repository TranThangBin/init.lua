require("mason-null-ls").setup({
	-- ensure installed with mason-null-ls
	ensure_installed = {
		"stylua",
		"prettierd",
		"csharpier",
		"goimports-reviser",
	},
})

require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})
