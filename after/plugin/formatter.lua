local util = require("formatter.util")

require("formatter").setup({
	-- Enable or disable logging
	logging = true,
	-- Set the log level
	log_level = vim.log.levels.WARN,
	filetype = {
		["lua"] = { require("formatter.filetypes.lua").stylua },
		["python"] = { require("formatter.filetypes.python").black },
		["c"] = { require("formatter.filetypes.c").clangformat },
		["cpp"] = { require("formatter.filetypes.cpp").clangformat },
		["cs"] = { require("formatter.filetypes.cs").clangformat },
		["go"] = {
			function()
				return {
					exe = "goimports-reviser",
					args = {
						-- "-rm-unused",
						"-set-alias",
						"-format",
						"-output",
						"stdout",
						util.escape_path(util.get_current_buffer_file_path()),
					},
					stdin = true,
				}
			end,
		},
		["*"] = {
			-- prettierd
			function()
				return {
					exe = "prettierd",
					args = { util.escape_path(util.get_current_buffer_file_path()) },
					stdin = true,
				}
			end,
		},
		-- other formatters ...
	},
})

vim.api.nvim_create_autocmd("BufWritePost", {
	callback = function()
		vim.cmd("FormatWrite")
	end,
})
