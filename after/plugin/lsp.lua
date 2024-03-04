local ok, lsp_zero = pcall(require, "lsp-zero")

local mason_config = {
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
}

local function mason_lspconfig_handler(_lsp_zero, _lsp_config)
	return {
		_lsp_zero.default_setup,
		eslint = _lsp_zero.noop,
		lua_ls = function()
			local lua_opts = _lsp_zero.nvim_lua_ls()
			_lsp_config.lua_ls.setup(lua_opts)
		end,
	}
end

local function cmp_mapping(_cmp, _cmp_action)
	return _cmp.mapping.preset.insert({
		-- confirm completion item
		["<CR>"] = _cmp.mapping.confirm({ select = false }),
		["<Tab>"] = _cmp.mapping.confirm({ select = false }),

		-- toggle completion menu
		["<C-n>"] = _cmp_action.toggle_completion(),

		-- tab complete
		["<C-j>"] = _cmp.mapping.select_next_item(),
		["<C-k>"] = _cmp.mapping.select_prev_item(),

		-- navigate between snippet placeholder
		["<C-d>"] = _cmp_action.luasnip_jump_forward(),
		["<C-b>"] = _cmp_action.luasnip_jump_backward(),

		-- scroll documentation window
		["<C-f>"] = _cmp.mapping.scroll_docs(-5),
		-- ["<C-d>"] = cmp.mapping.scroll_docs(5),
	})
end

local function cmp_window(_cmp)
	return {
		completion = _cmp.config.window.bordered(),
		documentation = _cmp.config.window.bordered(),
	}
end

local cmp_sources = {
	{ name = "path" },
	{ name = "nvim_lsp" },
	{ name = "nvim_lua" },
	{ name = "buffer", keyword_length = 3 },
	{ name = "luasnip", keyword_length = 2 },
}

local lsp_zero_preferences = {
	sign_icons = {
		error = "✘",
		warn = "▲",
		hint = "⚑",
		info = "",
	},
}

local lsp_overloads_config = {
	ui = {
		border = "single",
		height = nil,
		width = nil,
		wrap = true,
		wrap_at = nil,
		max_width = nil,
		max_height = nil,
		close_events = { "CursorMoved", "BufHidden", "InsertLeave" },
		focusable = true,
		focus = false,
		offset_x = 0,
		offset_y = 0,
		floating_window_above_cur_line = false,
	},
	keymaps = {
		next_signature = "<C-j>",
		previous_signature = "<C-k>",
		next_parameter = "<C-l>",
		previous_parameter = "<C-h>",
		close_signature = "<A-s>",
	},
	display_automatically = false,
}

local function lsp_on_attach(client, bufnr)
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
	-- vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
	if client.server_capabilities.signatureHelpProvider then
		require("lsp-overloads").setup(client, lsp_overloads_config)
		vim.keymap.set({ "n", "i" }, "<A-s>", vim.cmd.LspOverloadsSignature, opts)
	end
end

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

if ok then
	local lsp_config = require("lspconfig")

	lsp_zero.preset("recommended")

	require("mason").setup(mason_config)

	require("mason-lspconfig").setup({
		handlers = mason_lspconfig_handler(lsp_zero, lsp_config),
	})

	local cmp = require("cmp")
	require("luasnip.loaders.from_vscode").lazy_load()
	vim.opt.completeopt = { "menu", "menuone", "noselect" }

	cmp.setup({
		mapping = cmp_mapping(cmp, lsp_zero.cmp_action()),

		sources = cmp_sources,
		window = cmp_window(cmp),
		preselect = "item",
		completion = {
			completeopt = "menu,menuone,noinsert",
		},
		formatting = lsp_zero.cmp_format(),
	})

	lsp_zero.set_preferences(lsp_zero_preferences)

	lsp_zero.on_attach(lsp_on_attach)

	lsp_zero.setup()
end
