return {
	"tjdevries/express_line.nvim",

	dir = "~/personal/nvim/express_line.nvim",

	dependencies = { "nvim-tree/nvim-web-devicons", "rose-pine" },

	opts = function()
		local builtin = require("el.builtin")
		local extensions = require("el.extensions")
		local sections = require("el.sections")
		local subscribe = require("el.subscribe")
		local devicons = require("nvim-web-devicons")

		local stl_base_bg = require("rose-pine.palette").base

		vim.api.nvim_set_hl(0, "StatusLine", { bg = stl_base_bg })

		for _, hi_group in pairs(require("el.data").mode_highlights) do
			local hl_group =
				vim.api.nvim_get_hl(0, { name = hi_group, link = false })
			vim.api.nvim_set_hl(
				0,
				hi_group,
				{ fg = hl_group.fg, bg = stl_base_bg }
			)
			vim.api.nvim_set_hl(
				0,
				hi_group .. "Inactive",
				{ link = "StatusLineNC" }
			)
		end

		local segments = {}

		local opts = {
			generator = function()
				return segments
			end,
		}

		table.insert(
			segments,
			extensions.gen_mode({ format_string = " %s " })
		)

		table.insert(segments, " ")

		table.insert(segments, builtin.file_relative)

		table.insert(segments, " ")

		table.insert(segments, function(win, buf)
			local icon, icon_hi_group =
				devicons.get_icon(vim.fn.expand("%:t"), buf.extension, {})

			local icon_hl = vim.api.nvim_get_hl(0, { name = icon_hi_group })

			icon_hi_group = "StatusLineFileTypeIcon"

			vim.api.nvim_set_hl(
				0,
				icon_hi_group,
				{ fg = icon_hl.fg, bg = stl_base_bg }
			)

			local fileicon = sections.highlight({
				active = icon_hi_group,
			}, icon)

			return fileicon(win, buf)
		end)

		table.insert(segments, "  ")

		table.insert(segments, builtin.modified)

		table.insert(segments, " ")

		table.insert(segments, builtin.readonly)

		table.insert(segments, " ")

		table.insert(segments, builtin.help)

		table.insert(segments, " ")

		table.insert(segments, builtin.preview)

		table.insert(segments, sections.split)

		table.insert(segments, require("el.diagnostic").make_buffer())

		table.insert(segments, " ")

		table.insert(
			segments,
			subscribe.buf_autocmd(
				"el-git-changes",
				"BufWritePost",
				function(win, buf)
					local changes = extensions.git_changes(win, buf)

					if changes ~= nil then
						return changes .. " ✘"
					end
				end
			)
		)

		table.insert(segments, sections.split)

		table.insert(
			segments,
			subscribe.buf_autocmd(
				"el-git-branch",
				"BufEnter",
				function(win, buf)
					local branch = extensions.git_branch(win, buf)

					if branch ~= nil then
						return " " .. branch .. " "
					end
				end
			)
		)

		table.insert(segments, " ")

		table.insert(segments, " ")

		table.insert(segments, function(win, buf)
			local ff = vim.bo.fileformat
			local ff_os = vim.uv.os_uname().sysname:lower()

			if ff == "unix" then
				ff_os = "linux"
			elseif ff == "dos" then
				ff_os = "windows"
			elseif ff == "mac" then
				ff_os = "apple"
			end

			local icon_tbl = devicons.get_icons_by_operating_system()[ff_os]

			local ff_hi_group = "StatusLineFileFormatIcon"

			vim.api.nvim_set_hl(0, ff_hi_group, {
				fg = icon_tbl.color,
				bg = stl_base_bg,
			})

			local icon = sections.highlight({
				active = ff_hi_group,
			}, icon_tbl.icon)

			return ff .. " " .. icon(win, buf)
		end)

		table.insert(segments, "  ")

		table.insert(segments, "%{&encoding}")

		table.insert(segments, " ")

		table.insert(segments, " ")
		table.insert(segments, builtin.percentage_through_file)
		table.insert(segments, "%%")
		table.insert(segments, " ")

		table.insert(segments, " ")
		table.insert(segments, builtin.line_with_width(3))
		table.insert(segments, ":")
		table.insert(segments, builtin.column_with_width(2))
		table.insert(segments, " ")

		return opts
	end,
}
