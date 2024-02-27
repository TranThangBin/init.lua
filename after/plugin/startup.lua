local ok, startup = pcall(require, "startup")

if ok then
	local dashboard = require("startup.themes.dashboard")
	local pokemon
	ok, pokemon = pcall(require, "pokemon")

	if ok then
		pokemon.setup({
			number = ({
				"0025",
				"0006.3",
				"0039",
			})[math.random(1, 3)],
			size = "small",
		})

		dashboard.header.content = pokemon.header()
		dashboard.header.highlight = "String"

		vim.keymap.set("n", "<leader>pk", vim.cmd.PokemonTogglePokedex)
	end

	startup.setup(dashboard)
end
