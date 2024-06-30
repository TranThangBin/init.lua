return {
	"tjdevries/express_line.nvim",

	dir = "~/personal/nvim/express_line.nvim",

	dependencies = "nvim-tree/nvim-web-devicons",

	opts = function()
		local builtin = require("el.builtin")
		local extensions = require("el.extensions")
		local sections = require("el.sections")
		local subscribe = require("el.subscribe")
		local devicons = require("nvim-web-devicons")

		local set_hl = vim.api.nvim_set_hl

		local segments = {}

		local opts = {
			generator = function()
				return segments
			end,
		}

		table.insert(
			segments,
			extensions.gen_mode({ format_string = " %s " })
		)

		table.insert(segments, " ")

		table.insert(segments, builtin.file_relative)

		table.insert(segments, " ")

		table.insert(
			segments,
			extensions.file_icon({
				format_string = "%s ",
				color_icon = true,
			})
		)

		table.insert(segments, " ")

		table.insert(segments, builtin.modified)

		table.insert(segments, builtin.readonly)

		table.insert(segments, builtin.help)

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
						branch = sections.highlight({
							active = "String",
						}, " " .. branch .. " ")
						return branch(win, buf)
					end
				end
			)
		)

		table.insert(segments, " ")

		table.insert(segments, function(win, buf)
			local ff = buf.fileformat
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

			set_hl(0, ff_hi_group, { fg = icon_tbl.color })

			local fileformat = sections.highlight({
				active = ff_hi_group,
			}, string.format(" %s %s", ff, icon_tbl.icon))

			return fileformat(win, buf)
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
