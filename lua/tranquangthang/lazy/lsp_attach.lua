local function default_filter()
	return true
end

local function null_ls_filter(client)
	return client.name == "null-ls"
end

return {
	"Issafalcon/lsp-overloads.nvim",

	dependencies = {
		"VonHeikemen/lsp-zero.nvim",
		"nvim-telescope/telescope.nvim",
	},

	opts = {
		ui = {
			border = "rounded",
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
			silent = true,
			highlight = {
				italic = true,
				bold = true,
				fg = "#ffffff",
				...,
			},
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
				vim.keymap.set(mode, lhs, rhs, remap_opts)
			end

			local builtin = require("telescope.builtin")

			map("n", "gd", builtin.lsp_definitions)

			map("n", "gr", builtin.lsp_references)

			map("n", "<leader>ws", builtin.lsp_workspace_symbols)

			map("n", "<leader>ds", builtin.lsp_document_symbols)

			map("n", "K", vim.lsp.buf.hover)

			map("n", "<leader>vd", vim.diagnostic.open_float)

			map("n", "]d", vim.diagnostic.goto_next)

			map("n", "[d", vim.diagnostic.goto_prev)

			map("n", "<leader>ca", vim.lsp.buf.code_action)

			map("n", "<leader>rn", vim.lsp.buf.rename)

			local format_opts = { async = true }

			map("n", "<leader>f", function()
				if format_opts.filter == nil then
					local null_ls = vim.lsp.get_clients({
						name = "null-ls",
						bufnr = bufnr,
					})[1]

					if null_ls == nil then
						format_opts.filter = default_filter
					else
						format_opts.filter = null_ls_filter
					end
				end

				vim.lsp.buf.format(format_opts)
			end)

			if client.supports_method("signatureHelpProvider") then
				require("lsp-overloads").setup(client, opts)
				map({ "n", "i" }, "<A-s>", vim.cmd.LspOverloadsSignature)
			end
		end)
	end,
}
