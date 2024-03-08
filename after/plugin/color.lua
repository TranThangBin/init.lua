local themes = {
    "rose-pine",
    "rose-pine-moon",
    "rose-pine-main",
    "rose-pine-dawn",
    "tokyonight-night",
    "tokyonight-storm",
    "tokyonight-day",
    "tokyonight-moon",
}

for i = 1, #themes do
    vim.keymap.set("n", "<leader>cl" .. i, function()
        local theme = themes[i]
        vim.cmd.colorscheme(theme)
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end)
end
