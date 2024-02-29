local lsp_zero = require("lsp-zero")

return {
	lsp_zero = lsp_zero,

	setup = function()
		lsp_zero.preset("recommended")

		require("configs.mason-lspconfig").setup()

		require("configs.cmp").setup()

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
				require("configs.lsp-overload").setup(client)
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
	end,
}
