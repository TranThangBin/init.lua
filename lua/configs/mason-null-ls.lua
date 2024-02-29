return {
	ensure_installed = function()
		vim.api.nvim_create_user_command("SetupFmt", function()
			require("mason-null-ls").setup({
				-- for formatter
				ensure_installed = {
					"stylua",
					"black",
					"clang-format",
					"prettierd",
				},
			})
		end, {})
	end,
}
