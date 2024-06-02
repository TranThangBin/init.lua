return {
	"Issafalcon/lsp-overloads.nvim",

	dependencies = {
		"VonHeikemen/lsp-zero.nvim",
		"nvim-telescope/telescope.nvim",
	},

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
		require("lsp-zero").on_attach(function(client, bufnr)
			local function map(mode, lhs, rhs, remap_opts)
				remap_opts = remap_opts or {}
				remap_opts.buffer = bufnr
				remap_opts.remap = false
				remap_opts.desc = "LSP: " .. (remap_opts.desc or "no description")
				vim.keymap.set(mode, lhs, rhs, remap_opts)
			end
			local builtin = require("telescope.builtin")

			map("n", "gd", builtin.lsp_definitions, { desc = "[g]o [t]o definition" })
			map("n", "gr", builtin.lsp_references, { desc = "[g]o [t]o references" })
			map(
				"n",
				"<leader>ws",
				builtin.lsp_workspace_symbols,
				{ desc = "[w]ork space [s]ymbols" }
			)
			map("n", "<leader>ds", builtin.lsp_document_symbols, { desc = "[d]ocument [s]ymbols" })
			map("n", "K", vim.lsp.buf.hover, { desc = "hover" })
			map("n", "<leader>vd", vim.diagnostic.open_float, { desc = "[v]isual [d]iagnostic" })
			map("n", "]d", vim.diagnostic.goto_next, { desc = "jump to next diagnostic" })
			map("n", "[d", vim.diagnostic.goto_prev, { desc = "jump to previous diagnostic" })
			map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[c]ode [a]ction" })
			map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[r]e[n]ame" })
			map("n", "<leader>f", function()
				vim.lsp.buf.format({ async = true })
			end, { desc = "[f]ormat" })

			if client.server_capabilities.signatureHelpProvider then
				require("lsp-overloads").setup(client, opts)
				vim.keymap.set(
					{ "n", "i" },
					"<A-s>",
					vim.cmd.LspOverloadsSignature,
					{ desc = "overload signature" }
				)
			end
		end)
	end,
}
