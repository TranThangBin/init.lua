return {
	"folke/lazydev.nvim",

	dependencies = {
		"hrsh7th/nvim-cmp",
		{ "Bilal2453/luvit-meta", lazy = true },
	},

	ft = "lua",

	opts = {
		runtime = vim.env.VIMRUNTIME,
		library = { path = "luvit-meta/library", words = { "vim%.uv" } },
		integrations = {
			lspconfig = true,
			cmp = true,
			coq = false,
		},
		enabled = function(_)
			return vim.g.lazydev_enabled == nil and true
				or vim.g.lazydev_enabled
		end,
	},
}
