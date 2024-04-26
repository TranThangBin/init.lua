return {
	"mhartington/formatter.nvim",

	opts = function()
		return {
			logging = true,
			log_level = vim.log.levels.WARN,
			filetype = {
				lua = { require("formatter.filetypes.lua").stylua },
				python = { require("formatter.filetypes.python").black },
				html = { require("formatter.defaults.prettierd") },
				svelte = { require("formatter.defaults.prettierd") },
				javascript = { require("formatter.defaults.biome") },
				typescript = { require("formatter.defaults.biome") },
				json = { require("formatter.defaults.biome") },
				sh = { require("formatter.filetypes.sh").shfmt },
				cmake = { require("formatter.filetypes.cmake").cmakeformat },
				templ = {
					function()
						return {
							exe = "templ",
							args = {
								"fmt",
							},
							stdin = true,
						}
					end,
				},
				["*"] = { require("formatter.filetypes.any").remove_trailing_whitespace },
			},
		}
	end,

	config = function(_, opts)
		require("formatter").setup(opts)
		vim.keymap.set("n", "<leader>fm", vim.cmd.Format)
	end,
}
