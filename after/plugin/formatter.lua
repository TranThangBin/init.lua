local formatter = require("formatter")

if formatter ~= nil then
	local util = require("formatter.util")

	formatter.setup({
		-- Enable or disable logging
		logging = true,
		-- Set the log level
		log_level = vim.log.levels.WARN,
		filetype = {
			lua = { require("formatter.filetypes.lua").stylua },
			python = { require("formatter.filetypes.python").black },
			c = { require("formatter.filetypes.c").clangformat },
			cpp = { require("formatter.filetypes.cpp").clangformat },
			cs = { require("formatter.filetypes.cs").clangformat },
			go = { require("formatter.filetypes.go").gofmt },
			javascript = { require("formatter.filetypes.javascript").prettierd },
			typescript = { require("formatter.filetypes.typescript").prettierd },
			["*"] = {
				require("formatter.filetypes.any").remove_trailing_whitespace,
				util.copyf(require("formatter.defaults").prettierd),
			},
		},
	})

	vim.api.nvim_create_autocmd("BufWritePost", {
		callback = function()
			vim.cmd("FormatWrite")
		end,
	})
end
