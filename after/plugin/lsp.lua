local ok, lsp_zero = pcall(require, "lsp-zero")

if ok then
	local lsp_config = require("lspconfig")

	lsp_zero.preset("recommended")

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
		handlers = {
			lsp_zero.default_setup,
			eslint = lsp_zero.noop,
			lua_ls = function()
				local lua_opts = lsp_zero.nvim_lua_ls()
				lsp_config.lua_ls.setup(lua_opts)
			end,
		},
	})

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

	lsp_zero.set_preferences({
		sign_icons = {
			error = "✘",
			warn = "▲",
			hint = "⚑",
			info = "",
		},
	})

	lsp_zero.on_attach(function(client, bufnr)
		local opts = { buffer = bufnr, remap = false }
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
		vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
		vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
		vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
		vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
		vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
		if client.server_capabilities.signatureHelpProvider then
			require("lsp-overloads").setup(client, {
				-- UI options are mostly the same as those passed to vim.lsp_zero.util.open_floating_preview
				ui = {
					border = "single", -- The border to use for the signature popup window. Accepts same border values as |nvim_open_win()|.
					height = nil, -- Height of the signature popup window (nil allows dynamic sizing based on content of the help)
					width = nil, -- Width of the signature popup window (nil allows dynamic sizing based on content of the help)
					wrap = true, -- Wrap long lines
					wrap_at = nil, -- Character to wrap at for computing height when wrap enabled
					max_width = nil, -- Maximum signature popup width
					max_height = nil, -- Maximum signature popup height
					-- Events that will close the signature popup window: use {"CursorMoved", "CursorMovedI", "InsertCharPre"} to hide the window when typing
					close_events = { "CursorMoved", "BufHidden", "InsertLeave" },
					focusable = true, -- Make the popup float focusable
					focus = false, -- If focusable is also true, and this is set to true, navigating through overloads will focus into the popup window (probably not what you want)
					offset_x = 0, -- Horizontal offset of the floating window relative to the cursor position
					offset_y = 0, -- Vertical offset of the floating window relative to the cursor position
					floating_window_above_cur_line = false, -- Attempt to float the popup above the cursor position
					-- (note, if the height of the float would be greater than the space left above the cursor, it will default
					-- to placing the float below the cursor. The max_height option allows for finer tuning of this)
				},
				keymaps = {
					next_signature = "<C-j>",
					previous_signature = "<C-k>",
					next_parameter = "<C-l>",
					previous_parameter = "<C-h>",
					close_signature = "<A-s>",
				},
				display_automatically = true, -- Uses trigger characters to automatically display the signature overloads when typing a method signature
			})
			vim.keymap.set({ "n", "i" }, "<A-s>", vim.cmd.LspOverloadsSignature)
		end
	end)

	lsp_zero.setup()

	vim.diagnostic.config({
		virtual_text = false,
		severity_sort = true,
		float = {
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	})
	vim.keymap.set("n", "<A-d>", function()
		vim.diagnostic.open_float(0, { scope = "line" })
	end)
end
