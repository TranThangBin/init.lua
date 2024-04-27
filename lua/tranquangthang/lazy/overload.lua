return {
	"Issafalcon/lsp-overloads.nvim",

	dependencies = { "nvim-telescope/telescope.nvim" },

	opts = {
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
	},

	config = function(_, opts)
		vim.api.nvim_create_autocmd("LspAttach", {
			group = MyGroup,
			callback = function(args)
				local bufnr = args.buf
				local client = vim.lsp.get_client_by_id(args.data.client_id)

				local remap_opts = { buffer = bufnr, remap = false }
				local builtin = require("telescope.builtin")

				vim.keymap.set("n", "gd", builtin.lsp_definitions, remap_opts)
				vim.keymap.set("n", "gr", builtin.lsp_references, remap_opts)
				vim.keymap.set("n", "<leader>vws", builtin.lsp_workspace_symbols, remap_opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, remap_opts)
				vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, remap_opts)
				vim.keymap.set("n", "[d", vim.diagnostic.goto_next, remap_opts)
				vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, remap_opts)
				vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, remap_opts)
				vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, remap_opts)
				vim.keymap.set("n", "<leader>fl", vim.lsp.buf.format, remap_opts)

				if client.server_capabilities.signatureHelpProvider then
					require("lsp-overloads").setup(client, opts)
					vim.keymap.set({ "n", "i" }, "<A-s>", vim.cmd.LspOverloadsSignature, remap_opts)
				end
			end,
		})
	end,
}
