return {
    "folke/zen-mode.nvim",

    opts = function()
        local number = vim.wo.number
        local rnu = vim.wo.rnu
        local colorcolumn = vim.opt.colorcolumn

        return {
            window = {
                backdrop = 95,
                width = 0.9,
                height = 1,
                options = {},
            },
            plugins = {
                options = {
                    enabled = true,
                    ruler = false,
                    laststatus = 0,
                },
                twilight = { enabled = true },
                gitsigns = { enabled = false },
                tmux = { enabled = true },
                kitty = {
                    enabled = false,
                    font = "+4",
                },
                alacritty = {
                    enabled = false,
                    font = "14",
                },
                wezterm = {
                    enabled = false,
                    font = "+4",
                },
            },
            on_close = function()
                if vim.bo.filetype ~= "netrw" then
                    vim.wo.number = number
                    vim.wo.rnu = rnu
                    vim.opt.colorcolumn = colorcolumn
                end
            end,
        }
    end,

    config = function(_, opts)
        local zen_mode = require("zen-mode")

        zen_mode.setup(opts)

        vim.keymap.set("n", "<leader>zz", zen_mode.toggle)
        vim.keymap.set("n", "<leader>zZ", function()
            zen_mode.toggle({
                window = {
                    width = 85,
                    options = {
                        signcolumn = "no",
                        number = false,
                        relativenumber = false,
                        cursorline = false,
                        cursorcolumn = false,
                        foldcolumn = "0",
                        list = false,
                    },
                },
            })
        end)
    end,
}
