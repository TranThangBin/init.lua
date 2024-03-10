return {
	logging = true,
	log_level = vim.log.levels.WARN,
	filetype = {
		lua = { require("formatter.filetypes.lua").stylua },
		python = { require("formatter.filetypes.python").black },
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
		javascript = { require("formatter.filetypes.javascript").prettierd },
		typescript = { require("formatter.filetypes.typescript").prettierd },
		json = { require("formatter.filetypes.json").prettierd },
		["*"] = { require("formatter.filetypes.any").remove_trailing_whitespace },
	},
}
