return {
	"tjdevries/express_line.nvim",

	dependencies = "nvim-tree/nvim-web-devicons",

	opts = function()
		local builtin = require("el.builtin")
		local extensions = require("el.extensions")
		local sections = require("el.sections")
		local subscribe = require("el.subscribe")
		local get_icon = require("nvim-web-devicons").get_icon

		local opts = {}

		function opts.generator()
			return {
				extensions.mode,
				" ",
				subscribe.buf_autocmd(
					"el-git-branch",
					"BufEnter",
					function(win, buf)
						return extensions.git_branch(win, buf) .. "  "
					end
				),
				subscribe.buf_autocmd(
					"el-git-changes",
					"BufWritePost",
					function(win, buf)
						return extensions.git_changes(win, buf) .. " ✘ "
					end
				),

				sections.split,
				"%f",
				" ",
				function(win, buf)
					local icon, icon_hl = get_icon(buf.name, buf.extension)
					local fileicon = sections.highlight({
						active = icon_hl,
						inactive = "StatusLine",
					}, icon)
					return fileicon(win, buf)
				end,

				sections.split,
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
