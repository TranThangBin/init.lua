require("rose-pine").setup({
	variant = "auto", -- auto, main, moon, or dawn
	dark_variant = "main", -- main, moon, or dawn
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

		headings = {
			h1 = "iris",
			h2 = "foam",
			h3 = "rose",
			h4 = "gold",
			h5 = "pine",
			h6 = "foam",
		},
		-- Alternatively, set all headings at once.
		-- headings = "subtle",
	},

	highlight_groups = {
		Comment = { fg = "foam" },
		VertSplit = { fg = "muted", bg = "muted" },
	},

	before_highlight = function(
		_ --[[ group ]],
		highlight,
		palette
	)
		-- Disable all undercurls
		if highlight.undercurl then
			highlight.undercurl = false
		end

		-- Change palette colour
		if highlight.fg == palette.pine then
			highlight.fg = palette.foam
		end
	end,
})

local themes = {
	"rose-pine-moon",
	"rose-pine-main",
	"rose-pine-dawn",
	"tokyonight-night",
	"tokyonight-storm",
	"tokyonight-day",
	"tokyonight-moon",
}

function ColorMyPencils(themeIndex)
	local theme = themes[themeIndex] or themes[1]
	vim.cmd.colorscheme(theme)
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()
