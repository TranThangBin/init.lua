local util = require("formatter.util")

require("formatter").setup({
	-- Enable or disable logging
	logging = true,
	-- Set the log level
	log_level = vim.log.levels.WARN,
	filetype = {
		["lua"] = {
			require("formatter.filetypes.lua").stylua,
		},
		["python"] = {
			require("formatter.filetypes.python").black,
		},
		["cs"] = {
			function()
				-- csharpier
				return {
					exe = "dotnet-csharpier",
					args = {
						"--write-stdout",
						"--check",
						util.escape_path(util.get_current_buffer_file_path()),
					},
					stdin = true,
				}
			end,
		},
		["go"] = {
			function()
				return {
					exe = "goimports-reviser",
					args = {
						"-rm-unused",
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
				local current_file = vim.api.nvim_buf_get_name(0)
				local is_gitignore = current_file:match("%.gitignore$")
				local is_markdown = current_file:match("%.md$")
				local is_ignored_files = is_gitignore or is_markdown
				if is_ignored_files then
					return nil
				end
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

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.cs",
	callback = function()
		if vim.opt.fileformat ~= "unix" then
			vim.opt.fileformat = "unix"
		end
	end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
	callback = function()
		vim.cmd("FormatWrite")
	end,
})
