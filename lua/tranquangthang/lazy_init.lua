local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

MyGroup = vim.api.nvim_create_augroup("tranquangthang", {})

require("lazy").setup({
	spec = "tranquangthang.lazy",
	change_detection = { notify = false },
	ui = {
		size = { width = 0.8, height = 0.8 },
		wrap = true,
		border = "single",
		backdrop = 60,
		title = nil,
		title_pos = "center",
		pills = true,
		icons = {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
			loaded = "●",
			not_loaded = "○",
			list = {
				"●",
				"➜",
				"★",
				"‒",
			},
		},
	},
})
