local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>tf", builtin.find_files, {})
vim.keymap.set("n", "<leader>tg", builtin.git_files, {})

require("telescope").setup()
