local ok, formatter = pcall(require, "formatter")

if ok then
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
			json = { require("formatter.filetypes.json").prettierd },
			["*"] = { require("formatter.filetypes.any").remove_trailing_whitespace },
		},
	})

	vim.keymap.set("n", "<leader>fm", function()
		vim.cmd("Format")
	end)
end
