return {
	"folke/lazydev.nvim",

	dependencies = {
		"hrsh7th/nvim-cmp",
		{ "Bilal2453/luvit-meta", lazy = true },
	},

	cond = vim.fn.has("nvim-0.10.0") == 1,

	ft = "lua",

	opts = {
		runtime = vim.env.VIMRUNTIME,
		library = { path = "luvit-meta/library", words = { "vim%.uv" } },
		integrations = { lspconfig = true, cmp = true, coq = false },
		enabled = function(root_dir)
			return (vim.g.lazydev_enabled == nil or vim.g.lazydev_enabled)
				and not vim.uv.fs_stat(root_dir .. "/.luarc.json")
		end,
	},
}
