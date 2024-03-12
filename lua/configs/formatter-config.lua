local stylua = require("formatter.filetypes.lua").stylua

local black = require("formatter.filetypes.python").black

local prettierd = require("formatter.defaults.prettierd")

local biome = require("formatter.defaults.biome")

local function templfmt()
	return {
		exe = "templ",
		args = {
			"fmt",
		},
		stdin = true,
	}
end

local trim_trail = require("formatter.filetypes.any").remove_trailing_whitespace

return {
	logging = true,
	log_level = vim.log.levels.WARN,
	filetype = {
		lua = { stylua },
		python = { black },
		html = { prettierd },
		svelte = { prettierd },
		javascript = { biome },
		typescript = { biome },
		json = { biome },
		templ = { templfmt },
		["*"] = { trim_trail },
	},
}
