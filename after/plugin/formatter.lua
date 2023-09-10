local formatter = require("formatter")
local mason_null_ls = require("mason-null-ls")

mason_null_ls.setup({
	-- ensure installed with mason-null-ls
	ensure_installed = {
		"stylua",
		"prettierd",
		"csharpier",
	},
})

formatter.setup({
	-- Enable or disable logging
	logging = true,
	-- Set the log level
	log_level = vim.log.levels.WARN,
	filetype = {
		lua = {
			function()
				-- stylua
				return {
					exe = "stylua",
					args = {
						"--search-parent-directories",
						"--stdin-filepath",
						vim.api.nvim_buf_get_name(0),
						"--",
						"-",
					},
					stdin = true,
				}
			end,
		},
		cs = {
			function()
				-- csharpier
				return {
					exe = "dotnet-csharpier",
					args = { "--write-stdout", vim.api.nvim_buf_get_name(0) },
					stdin = true,
				}
			end,
		},
		["*"] = {
			-- prettierd
			function()
				return {
					exe = "prettierd",
					args = { vim.api.nvim_buf_get_name(0) },
					stdin = true,
				}
			end,
		},
		-- other formatters ...
	},
})

vim.cmd("autocmd BufWritePost * FormatWrite")
