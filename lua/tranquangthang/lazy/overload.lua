local overloads_config = {
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

return {
	"Issafalcon/lsp-overloads.nvim",

	dependencies = { "nvim-telescope/telescope.nvim" },

	config = function()
		local my_group = vim.api.nvim_create_augroup("tranquangthang", {})

		vim.api.nvim_create_autocmd("LspAttach", {
			group = my_group,
			callback = function(args)
				local bufnr = args.buf
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				local opts = { buffer = bufnr, remap = false }
				local builtin = require("telescope.builtin")

				vim.keymap.set("n", "gd", builtin.lsp_definitions, opts)
				vim.keymap.set("n", "gr", builtin.lsp_references, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "<leader>vws", builtin.lsp_workspace_symbols, opts)
				vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
				vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
				vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
				vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "<leader>fl", vim.lsp.buf.format, opts)
				if client.server_capabilities.signatureHelpProvider then
					require("lsp-overloads").setup(client, overloads_config)
					vim.keymap.set({ "n", "i" }, "<A-s>", vim.cmd.LspOverloadsSignature, opts)
				end
			end,
		})
	end,
}
