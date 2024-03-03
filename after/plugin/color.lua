local ok, rose_pine = pcall(require, "rose-pine")

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

local config = {
	variant = "auto",
	dark_variant = "main",
	dim_inactive_windows = false,
	extend_background_behind_borders = true,

	styles = {
		bold = true,
		italic = false,
		transparency = true,
	},

	groups = {
		border = "muted",
		link = "iris",
		panel = "surface",

		error = "love",
		hint = "iris",
		info = "foam",
		warn = "gold",

		git_add = "foam",
		git_change = "rose",
		git_delete = "love",
		git_dirty = "rose",
		git_ignore = "muted",
		git_merge = "iris",
		git_rename = "pine",
		git_stage = "iris",
		git_text = "rose",
		git_untracked = "subtle",

		headings = "subtle",
	},
}

for i = 1, #themes do
	vim.keymap.set("n", "<leader>cl" .. i, function()
		ColorMyPencils(i)
	end)
end

if ok then
	rose_pine.setup(config)

	ColorMyPencils()
end
