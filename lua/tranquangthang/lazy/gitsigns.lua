return {
	"lewis6991/gitsigns.nvim",

	opts = {
		signs = {
			add = { text = "┃" },
			change = { text = "┃" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "┆" },
		},
		signcolumn = true,
		numhl = false,
		linehl = false,
		word_diff = false,
		watch_gitdir = {
			follow_files = true,
		},
		auto_attach = true,
		attach_to_untracked = false,
		current_line_blame = false,
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = "eol",
			delay = 1000,
			ignore_whitespace = false,
			virt_text_priority = 100,
		},
		current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
		current_line_blame_formatter_opts = {
			relative_time = false,
		},
		sign_priority = 6,
		update_debounce = 100,
		status_formatter = nil,
		max_file_length = 40000,
		preview_config = {
			border = "single",
			style = "minimal",
			relative = "cursor",
			row = 0,
			col = 1,
		},
		on_attach = function(bufnr)
			local gitsigns = require("gitsigns")

			local function map(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			-- Navigation
			map("n", "]g", function()
				if vim.wo.diff then
					vim.cmd.normal({ "]g", bang = true })
				else
					gitsigns.nav_hunk("next")
				end
			end, { desc = "Gitsigns: jump to the next hunk" })

			map("n", "[g", function()
				if vim.wo.diff then
					vim.cmd.normal({ "[g", bang = true })
				else
					gitsigns.nav_hunk("prev")
				end
			end, { desc = "Gitsigns: jump to the previous hunk" })

			-- Actions
			map(
				"n",
				"<leader>hs",
				gitsigns.stage_hunk,
				{ desc = "Gitsigns: [h]unk [s]tage" }
			)
			map(
				"n",
				"<leader>hr",
				gitsigns.reset_hunk,
				{ desc = "Gitsigns: [h]unk [r]eset" }
			)
			map("v", "<leader>hs", function()
				gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "Gitsigns: [h]unk [s]tage current line" })
			map("v", "<leader>hr", function()
				gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "Gitsigns: [h]unk [r]eset current line" })
			map(
				"n",
				"<leader>hS",
				gitsigns.stage_buffer,
				{ desc = "Gitsigns: [h]unk [S]tage buffer" }
			)
			map(
				"n",
				"<leader>hu",
				gitsigns.undo_stage_hunk,
				{ desc = "Gitsigns: [h]unk [u]ndo stage" }
			)
			map(
				"n",
				"<leader>hR",
				gitsigns.reset_buffer,
				{ desc = "Gitsigns: [h]unk [R]eset buffer" }
			)
			map(
				"n",
				"<leader>hp",
				gitsigns.preview_hunk,
				{ desc = "Gitsigns: [h]unk [p]review" }
			)
			map("n", "<leader>hb", function()
				gitsigns.blame_line({ full = true })
			end, { desc = "Gitsigns: [h]unk [b]lame line" })
			map(
				"n",
				"<leader>tb",
				gitsigns.toggle_current_line_blame,
				{ desc = "Gitsigns: [t]oggle [b]lame on line" }
			)
			map(
				"n",
				"<leader>hd",
				gitsigns.diffthis,
				{ desc = "Gitsigns: [h]unk [d]iff this" }
			)
			map("n", "<leader>hD", function()
				gitsigns.diffthis("~")
			end, { desc = "Gitsigns: [h]unk [D]iff this by USER" })
			map(
				"n",
				"<leader>td",
				gitsigns.toggle_deleted,
				{ desc = "Gitsigns: [t]oggle [d]elete" }
			)

			map(
				{ "o", "x" },
				"ih",
				":<C-U>Gitsigns select_hunk<CR>",
				{ desc = "Gitsigns: select the hunk under the cursor" }
			)
		end,
	},
}
