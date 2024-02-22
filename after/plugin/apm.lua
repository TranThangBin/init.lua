local ok, apm = pcall(require, "vim-apm")

if ok then
	apm:setup({})
	vim.keymap.set("n", "<leader>apm", function()
		apm:toggle_monitor()
	end)
end
