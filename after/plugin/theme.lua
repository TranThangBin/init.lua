local themes = {
	"rose-pine",
	"tokyonight-night",
	"tokyonight-storm",
	"tokyonight-day",
	"tokyonight-moon",
}

function SetTheme(themeIndex)
	local theme = themes[themeIndex] or themes[1]
	vim.cmd.colorscheme(theme)
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

SetTheme()
