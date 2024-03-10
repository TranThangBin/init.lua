vim.keymap.set("n", "<leader>xx", vim.cmd.TroubleToggle)

vim.keymap.set("n", "<leader>xw", function()
	vim.cmd.Trouble("workspace_diagnostics")
end)

vim.keymap.set("n", "<leader>xd", function()
	vim.cmd.Trouble("document_diagnostics")
end)

vim.keymap.set("n", "<leader>xq", function()
	vim.cmd.Trouble("quickfix")
end)

vim.keymap.set("n", "<leader>xl", function()
	vim.cmd.Trouble("loclist")
end)

vim.keymap.set("n", "gR", function()
	vim.cmd.Trouble("lsp_references")
end)
