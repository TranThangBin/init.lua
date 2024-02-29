return {
	setup = function()
		local lsp_zero = require("configs.lsp-zero").lsp_zero

		local cmp = require("cmp")
		local cmp_action = lsp_zero.cmp_action()
		require("luasnip.loaders.from_vscode").lazy_load()
		vim.opt.completeopt = { "menu", "menuone", "noselect" }

		cmp.setup({
			mapping = cmp.mapping.preset.insert({
				-- confirm completion item
				["<CR>"] = cmp.mapping.confirm({ select = false }),
				["<Tab>"] = cmp.mapping.confirm({ select = false }),

				-- toggle completion menu
				["<C-n>"] = cmp_action.toggle_completion(),

				-- tab complete
				["<C-j>"] = cmp.mapping.select_next_item(),
				["<C-k>"] = cmp.mapping.select_prev_item(),

				-- navigate between snippet placeholder
				["<C-d>"] = cmp_action.luasnip_jump_forward(),
				["<C-b>"] = cmp_action.luasnip_jump_backward(),

				-- scroll documentation window
				["<C-f>"] = cmp.mapping.scroll_docs(-5),
				-- ["<C-d>"] = cmp.mapping.scroll_docs(5),
			}),
			sources = {
				{ name = "path" },
				{ name = "nvim_lsp" },
				{ name = "nvim_lua" },
				{ name = "buffer", keyword_length = 3 },
				{ name = "luasnip", keyword_length = 2 },
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			preselect = "item",
			completion = {
				completeopt = "menu,menuone,noinsert",
			},
			formatting = lsp_zero.cmp_format(),
		})
	end,
}
