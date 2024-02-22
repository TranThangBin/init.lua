local apm = require("vim-apm")

if apm ~= nil then
	apm:setup({})
	vim.keymap.set("n", "<leader>apm", function()
		apm:toggle_monitor()
	end)
end
