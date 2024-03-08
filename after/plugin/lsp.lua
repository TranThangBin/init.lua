local ok, lsp_zero = pcall(require, "lsp-zero")

local sources = {
    { name = "path" },
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "buffer",  keyword_length = 3 },
    { name = "luasnip", keyword_length = 2 },
}

local preferences = {
    sign_icons = {
        error = "✘",
        warn = "▲",
        hint = "⚑",
        info = "",
    },
}

local overloads_config = {
    ui = {
        border = "single",
        height = nil,
        width = nil,
        wrap = true,
        wrap_at = nil,
        max_width = nil,
        max_height = nil,
        close_events = { "CursorMoved", "BufHidden", "InsertLeave" },
        focusable = true,
        focus = false,
        offset_x = 0,
        offset_y = 0,
        floating_window_above_cur_line = false,
    },
    keymaps = {
        next_signature = "<C-j>",
        previous_signature = "<C-k>",
        next_parameter = "<C-l>",
        previous_parameter = "<C-h>",
        close_signature = "<A-s>",
    },
    display_automatically = false,
}

local function lsp_on_attach(client, bufnr)
    local opts = { buffer = bufnr, remap = false }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format, opts)
    -- vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
    if client.server_capabilities.signatureHelpProvider then
        require("lsp-overloads").setup(client, overloads_config)
        vim.keymap.set({ "n", "i" }, "<A-s>", vim.cmd.LspOverloadsSignature, opts)
    end
end

vim.diagnostic.config({
    virtual_text = false,
    severity_sort = true,
    float = {
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
})

if ok then
    lsp_zero.preset("recommended")

    require("mason-lspconfig").setup({
        handlers = {
            lsp_zero.default_setup,
            eslint = lsp_zero.noop,
            lua_ls = function()
                local lua_opts = lsp_zero.nvim_lua_ls()
                require("lspconfig").lua_ls.setup(lua_opts)
            end,
        },
    })

    local cmp = require("cmp")
    local cmp_action = lsp_zero.cmp_action()
    require("luasnip.loaders.from_vscode").lazy_load()
    -- vim.opt.completeopt = { "menu", "menuone", "noselect" }

    cmp.setup({
        mapping = cmp.mapping.preset.insert({
            -- confirm completion item
            ["<CR>"] = cmp.mapping.confirm({ select = false }),
            ["<Tab>"] = cmp.mapping.confirm({ select = false }),

            -- toggle completion menu
            ["<C-n>"] = cmp_action.toggle_completion(),

            -- tab complete
            ["<C-j>"] = cmp.mapping.select_next_item(),
            ["<C-k>"] = cmp.mapping.select_prev_item(),

            -- navigate between snippet placeholder
            ["<C-w>"] = cmp_action.luasnip_jump_forward(),
            ["<C-b>"] = cmp_action.luasnip_jump_backward(),

            -- scroll documentation window
            ["<C-u>"] = cmp.mapping.scroll_docs(-5),
            ["<C-d>"] = cmp.mapping.scroll_docs(5),
        }),

        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },
        preselect = "item",
        completion = {
            completeopt = "menu,menuone,noinsert",
        },
        sources = sources,
        formatting = lsp_zero.cmp_format(),
    })

    lsp_zero.set_preferences(preferences)

    lsp_zero.on_attach(lsp_on_attach)

    lsp_zero.setup()
end
