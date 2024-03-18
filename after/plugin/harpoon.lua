local ok, harpoon = pcall(require, "harpoon")

local MAXFILES = 5

if ok then
    local ui = require("harpoon.ui")
    local term = require("harpoon.term")

    harpoon.setup()

    vim.keymap.set("n", "<leader>ha", require("harpoon.mark").add_file)
    vim.keymap.set("n", "<leader>hm", ui.toggle_quick_menu)
    vim.keymap.set("n", "<leader>hj", ui.nav_next)
    vim.keymap.set("n", "<leader>hk", ui.nav_prev)

    for i = 1, MAXFILES do
        vim.keymap.set("n", "<leader>h" .. i, function()
            ui.nav_file(i)
        end)
        vim.keymap.set("n", "<leader>t" .. i, function()
            term.gotoTerminal(i)
        end)
    end
end
