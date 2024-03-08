local is_open = false

local number = vim.wo.number
local rnu = vim.wo.rnu
local colorcolumn = vim.opt.colorcolumn

vim.keymap.set("n", "<leader>zz", function()
    vim.cmd.ZenMode()
    is_open = not is_open
    vim.wo.number = number
    vim.wo.rnu = rnu
    vim.opt.colorcolumn = colorcolumn
end)

vim.keymap.set("n", "<leader>zZ", function()
    vim.cmd.ZenMode()
    is_open = not is_open
    vim.wo.number = not is_open
    vim.wo.rnu = not is_open
    if is_open then
        vim.opt.colorcolumn = "0"
    else
        vim.opt.colorcolumn = colorcolumn
    end
end)
