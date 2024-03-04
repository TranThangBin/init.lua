local themes = {
	"rose-pine-moon",
	"rose-pine-main",
	"rose-pine-dawn",
	"tokyonight-night",
	"tokyonight-storm",
	"tokyonight-day",
	"tokyonight-moon",
}

local function ColorMyPencils(themeIndex)
	local theme = themes[themeIndex] or themes[1]
	vim.cmd.colorscheme(theme)
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

for i = 1, #themes do
	vim.keymap.set("n", "<leader>cl" .. i, function()
		ColorMyPencils(i)
	end)
end

ColorMyPencils()
