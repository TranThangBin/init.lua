return {
	"hrsh7th/nvim-cmp",

	dependencies = {
		"VonHeikemen/lsp-zero.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"saadparwaiz1/cmp_luasnip",
		"rafamadriz/friendly-snippets",
		{
			"L3MON4D3/LuaSnip",
			build = "make install_jsregexp",
		},
	},

	opts = function()
		local lsp_zero = require("lsp-zero")

		local cmp = require("cmp")
		local cmp_action = lsp_zero.cmp_action()

		return {
			preselect = "item",
			formatting = lsp_zero.cmp_format({ details = true }),

			mapping = cmp.mapping.preset.insert({
				["<CR>"] = cmp.mapping.confirm({ select = false }),
				["<Tab>"] = cmp.mapping.confirm({ select = false }),

				["<C-n>"] = cmp_action.toggle_completion({}),

				["<C-j>"] = cmp.mapping.select_next_item(),
				["<C-k>"] = cmp.mapping.select_prev_item(),

				["<C-w>"] = cmp_action.luasnip_jump_forward(),
				["<C-b>"] = cmp_action.luasnip_jump_backward(),

				["<C-u>"] = cmp.mapping.scroll_docs(-5),
				["<C-d>"] = cmp.mapping.scroll_docs(5),
			}),

			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},

			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},

			completion = {
				completeopt = "menu,menuone,noinsert",
			},

			sources = cmp.config.sources({
				{ name = "path" },
				{ name = "nvim_lsp" },
				{ name = "lazydev" },
				{ name = "luasnip" },
			}, {
				{ name = "buffer" },
			}),
		}
	end,

	config = function(_, opts)
		require("luasnip.loaders.from_vscode").lazy_load()

		vim.opt.completeopt = { "menu", "menuone", "noselect" }

		local cmp = require("cmp")

		cmp.setup(opts)

		cmp.setup.cmdline("/", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
		})
	end,
}
