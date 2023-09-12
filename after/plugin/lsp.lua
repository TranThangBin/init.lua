local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.nvim_workspace()

lsp.ensure_installed({
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
})

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_action = lsp.cmp_action()

local cmp_mappings = lsp.defaults.cmp_mappings({
	["<S-Tab>"] = cmp.mapping.select_prev_item(cmp_select),
	["<Tab>"] = cmp.mapping.select_next_item(cmp_select),
	["Enter"] = cmp.mapping.confirm({ select = true }),
	["<C-n>"] = cmp_action.toggle_completion(),
})

lsp.setup_nvim_cmp({
	mapping = cmp_mappings,
})

lsp.set_preferences({
	sign_icons = {
		error = "E",
		warn = "W",
		hint = "H",
		info = "I",
	},
})

lsp.skip_server_setup({ "eslint" })

lsp.setup()

vim.diagnostic.config({
	virtual_text = true,
})
