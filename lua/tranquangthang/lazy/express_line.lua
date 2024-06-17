return {
	"tjdevries/express_line.nvim",

	-- dir = "~/personal/lua/express_line.nvim",

	dependencies = { "nvim-tree/nvim-web-devicons", "rose-pine" },

	opts = function()
		local builtin = require("el.builtin")
		local extensions = require("el.extensions")
		local sections = require("el.sections")
		local subscribe = require("el.subscribe")
		local palete = require("rose-pine.palette")
		local devicons = require("nvim-web-devicons")
		local mode_highlights = require("el.data").mode_highlights

		local get_hl = vim.api.nvim_get_hl
		local set_hl = vim.api.nvim_set_hl

		local statusline_bg = palete.base

		for _, hl_group_name in pairs(mode_highlights) do
			local hl_group = get_hl(0, { name = hl_group_name })
			local link_hl_group = get_hl(0, { name = hl_group.link })

			set_hl(
				0,
				hl_group_name,
				{ bg = statusline_bg, fg = link_hl_group.fg }
			)
			set_hl(0, hl_group_name .. "Inactive", { link = "StatusLineNC" })
		end

		vim.api.nvim_set_hl(0, "StatusLine", { bg = statusline_bg })

		local opts = {}

		function opts.generator()
			return {
				extensions.mode,
				subscribe.buf_autocmd(
					"el-git-branch",
					"BufEnter",
					function(win, buf)
						local branch = extensions.git_branch(win, buf)

						if branch == nil then
							return ""
						end

						return "  " .. branch
					end
				),
				subscribe.buf_autocmd(
					"el-git-changes",
					"BufWritePost",
					function(win, buf)
						local changes = extensions.git_changes(win, buf)

						if changes == nil then
							return ""
						elseif changes == "" then
							return " ✔  "
						end

						return " ✘ " .. changes
					end
				),

				sections.split,
				"%f",
				" ",
				function(win, buf)
					local icon, icon_fg =
						devicons.get_icon_color_by_filetype(buf.extension)

					vim.api.nvim_set_hl(0, "StatusLineFiletypeIcon", {
						fg = icon_fg,
						bg = statusline_bg,
					})

					local fileicon = sections.highlight({
						active = "StatusLineFiletypeIcon",
					}, icon)
					return fileicon(win, buf)
				end,

				sections.split,
				function(win, buf)
					local ff = vim.bo.fileformat
					local ff_os = vim.uv.os_uname().sysname:lower()

					if ff == "unix" then
						ff_os = "linux"
					elseif ff == "dos" then
						ff_os = "windows"
					elseif ff == "mac" then
						ff_os = "apple"
					end

					local icon_tbl =
						devicons.get_icons_by_operating_system()[ff_os]

					vim.api.nvim_set_hl(0, "StatusLineFileformatIcon", {
						fg = icon_tbl.color,
						bg = statusline_bg,
					})

					local icon = sections.highlight({
						active = "StatusLineFileformatIcon",
					}, icon_tbl.icon)

					return icon(win, buf)
				end,
				" ",
				vim.bo.fileencoding,
				" ",
				"[",
				builtin.percentage_through_file,
				"%%",
				"]",
				"[",
				builtin.line_with_width(3),
				":",
				builtin.column_with_width(2),
				"]",
			}
		end

		return opts
	end,
}
