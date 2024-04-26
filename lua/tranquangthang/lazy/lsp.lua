local sources = {
	{ name = "path" },
	{ name = "nvim_lsp" },
	{ name = "nvim_lua" },
	{ name = "buffer", keyword_length = 3 },
	{ name = "luasnip", keyword_length = 2 },
}

local preferences = {
	sign_icons = {
		error = "✘",
		warn = "▲",
		hint = "⚑",
		info = "",
	},
}

local diagnostic_config = {
	virtual_text = false,
	severity_sort = true,
	float = {
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
}

return {
	"VonHeikemen/lsp-zero.nvim",

	branch = "v3.x",

	dependencies = {
		{ "neovim/nvim-lspconfig" },
		{ "williamboman/mason-lspconfig.nvim" },
		{ "hrsh7th/nvim-cmp" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-path" },
		{ "saadparwaiz1/cmp_luasnip" },
		{ "hrsh7th/cmp-nvim-lua" },
		{ "rafamadriz/friendly-snippets" },
		{
			"L3MON4D3/LuaSnip",
			build = "make install_jsregexp",
		},
		{
			"williamboman/mason.nvim",
			opts = {
				ui = {
					border = "single",

					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			},
		},
	},

	config = function()
		local lsp_zero = require("lsp-zero")

		lsp_zero.preset("recommended")

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

		local cmp = require("cmp")
		local cmp_action = lsp_zero.cmp_action()
		require("luasnip.loaders.from_vscode").lazy_load()
		vim.opt.completeopt = { "menu", "menuone", "noselect" }

		cmp.setup({
			mapping = cmp.mapping.preset.insert({
				["<CR>"] = cmp.mapping.confirm({ select = false }),
				["<Tab>"] = cmp.mapping.confirm({ select = false }),

				["<C-n>"] = cmp_action.toggle_completion(),

				["<C-j>"] = cmp.mapping.select_next_item(),
				["<C-k>"] = cmp.mapping.select_prev_item(),

				["<C-w>"] = cmp_action.luasnip_jump_forward(),
				["<C-b>"] = cmp_action.luasnip_jump_backward(),

				["<C-u>"] = cmp.mapping.scroll_docs(-5),
				["<C-d>"] = cmp.mapping.scroll_docs(5),
			}),

			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},

			preselect = "item",
			completion = {
				completeopt = "menu,menuone,noinsert",
			},

			sources = sources,
			formatting = lsp_zero.cmp_format(),
		})

		vim.diagnostic.config(diagnostic_config)

		lsp_zero.set_preferences(preferences)

		lsp_zero.setup()
	end,
}
