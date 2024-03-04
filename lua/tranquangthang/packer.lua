-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd("packadd packer.nvim")

return require("packer").startup(function(use)
    use("wbthomason/packer.nvim")

    use("nvim-treesitter/playground")

    use("ThePrimeagen/harpoon")

    use("ThePrimeagen/vim-be-good")

    use("folke/trouble.nvim")

    use("folke/zen-mode.nvim")

    use("gelguy/wilder.nvim")

    use("nvim-lua/plenary.nvim")

    use("nvim-telescope/telescope.nvim")

    use({
        "rose-pine/neovim",

        config = function()
            require("rose-pine").setup({
                variant = "auto",
                dark_variant = "main",
                dim_inactive_windows = false,
                extend_background_behind_borders = true,

                styles = {
                    bold = true,
                    italic = false,
                    transparency = true,
                },

                groups = {
                    border = "muted",
                    link = "iris",
                    panel = "surface",

                    error = "love",
                    hint = "iris",
                    info = "foam",
                    warn = "gold",

                    git_add = "foam",
                    git_change = "rose",
                    git_delete = "love",
                    git_dirty = "rose",
                    git_ignore = "muted",
                    git_merge = "iris",
                    git_rename = "pine",
                    git_stage = "iris",
                    git_text = "rose",
                    git_untracked = "subtle",

                    headings = "subtle",
                },
            })
        end,
    })

    use({
        "nvim-treesitter/nvim-treesitter",

        config = function()
            require("nvim-treesitter").setup({
                ensure_installed = { "javascript", "typescript", "c", "lua", "vim", "vimdoc", "query" },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
            })
        end,
    }, { run = ":TSUpdate" })

    use({
        "windwp/nvim-ts-autotag",

        config = function()
            require("nvim-ts-autotag").setup()
        end,
    })

    use({
        "mbbill/undotree",

        config = function()
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
        end,
    })

    use({
        "tpope/vim-fugitive",

        config = function()
            vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
            vim.keymap.set("n", "gl", "<cmd>diffget //2<CR>")
            vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>")
        end,
    })

    use({
        "VonHeikemen/lsp-zero.nvim",

        branch = "v3.x",

        requires = {
            -- LSP Support
            { "neovim/nvim-lspconfig" },    -- Required
            { "williamboman/mason.nvim" },  -- Optional
            { "williamboman/mason-lspconfig.nvim" }, -- Optional
            { "Issafalcon/lsp-overloads.nvim" },

            -- Autocompletion
            { "hrsh7th/nvim-cmp" }, -- Required
            { "hrsh7th/cmp-nvim-lsp" }, -- Required
            { "hrsh7th/cmp-buffer" }, -- Optional
            { "hrsh7th/cmp-path" }, -- Optional
            { "saadparwaiz1/cmp_luasnip" }, -- Optional
            { "hrsh7th/cmp-nvim-lua" }, -- Optional

            -- Snippets
            { "L3MON4D3/LuaSnip" },    -- Required
            { "rafamadriz/friendly-snippets" }, -- Optional
        },
    })

    use({
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    })

    use({
        "numToStr/Comment.nvim",

        config = function()
            require("Comment").setup({
                padding = true,
                sticky = true,
                ignore = nil,
                toggler = {
                    line = "gcc",
                    block = "gbc",
                },
                opleader = {
                    line = "gc",
                    block = "gb",
                },
                extra = {
                    above = "gcO",
                    below = "gco",
                    eol = "gcA",
                },
                mappings = {
                    basic = true,
                    extra = true,
                },
                pre_hook = nil,
                post_hook = nil,
            })
        end,
    })

    use({
        "nvim-tree/nvim-web-devicons",

        config = function()
            require("nvim-web-devicons").setup({
                override = {
                    zsh = {
                        icon = "",
                        color = "#428850",
                        cterm_color = "65",
                        name = "Zsh",
                    },
                },
                color_icons = true,
                default = true,
                strict = true,
                override_by_filename = {
                    [".gitignore"] = {
                        icon = "",
                        color = "#f1502f",
                        name = "Gitignore",
                    },
                },
                override_by_extension = {
                    ["log"] = {
                        icon = "",
                        color = "#81e043",
                        name = "Log",
                    },
                },
            })
        end,
    })

    use({
        "nvim-lualine/lualine.nvim",

        config = function()
            require("lualine").setup({
                options = {
                    icons_enabled = true,
                    theme = "auto",
                    component_separators = { left = "", right = "" },
                    section_separators = { left = "", right = "" },
                    disabled_filetypes = {
                        statusline = {},
                        winbar = {},
                    },
                    ignore_focus = {},
                    always_divide_middle = true,
                    globalstatus = false,
                    refresh = {
                        statusline = 1000,
                        tabline = 1000,
                        winbar = 1000,
                    },
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diff", "diagnostics" },
                    lualine_c = { "filename" },
                    lualine_x = { "encoding", "fileformat", "filetype" },
                    lualine_y = { "progress" },
                    lualine_z = { "location" },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { "filename" },
                    lualine_x = { "location" },
                    lualine_y = {},
                    lualine_z = {},
                },
                tabline = {},
                winbar = {},
                inactive_winbar = {},
                extensions = {},
            })
        end,
    })

    use({
        "prichrd/netrw.nvim",

        config = function()
            require("netrw").setup({
                -- Put your configuration here, or leave the object empty to take the default
                -- configuration.
                icons = {
                    symlink = "", -- Symlink icon (directory and file)
                    directory = "", -- Directory icon
                    file = "", -- File icon
                },
                use_devicons = true, -- Uses nvim-web-devicons if true, otherwise use the file icon specified above
                mappings = {}, -- Custom key mappings
            })
        end,
    })

    use({
        "LunarWatcher/auto-pairs",

        branch = "develop",

        config = function()
            vim.api.nvim_set_var("AutoPairsMapBS", 1)
            vim.api.nvim_set_var("AutoPairsMapBSIn", 1)
            vim.api.nvim_set_var("AutoPairsMapCR", 0)
        end,
    })

    use({
        "ThePrimeagen/vim-apm",

        -- config = function()
        -- 	local apm = require("vim-apm")
        --
        -- 	apm:setup({})
        -- 	vim.keymap.set("n", "<leader>apm", function()
        -- 		apm:toggle_monitor()
        -- 	end)
        -- end,
    })

    use({
        "kylechui/nvim-surround",

        tag = "*",

        config = function()
            require("nvim-surround").setup({
                keymaps = {
                    insert = "<C-g>s",
                    insert_line = "<C-g>S",
                    normal = "ys",
                    normal_cur = "yss",
                    normal_line = "yS",
                    normal_cur_line = "ySS",
                    visual = "S",
                    visual_line = "gS",
                    delete = "ds",
                    change = "cs",
                    change_line = "cS",
                },
            })
        end,
    })

    use({
        "startup-nvim/startup.nvim",

        config = function()
            local startup = require("startup")

            vim.keymap.set("n", "<leader>nf", startup.new_file)

            local dashboard = require("startup.themes.dashboard")

            dashboard.header.content = {
                "████████╗████████╗██████╗    ███╗  ██╗██╗   ██╗██╗███╗   ███╗",
                "╚══██╔══╝╚══██╔══╝██╔══██╗   ████╗ ██║██║   ██║██║████╗ ████║",
                "   ██║      ██║   ██████╦╝   ██╔██╗██║╚██╗ ██╔╝██║██╔████╔██║",
                "   ██║      ██║   ██╔══██╗   ██║╚████║ ╚████╔╝ ██║██║╚██╔╝██║",
                "   ██║      ██║   ██████╦╝██╗██║ ╚███║  ╚██╔╝  ██║██║ ╚═╝ ██║",
                "   ╚═╝      ╚═╝   ╚═════╝ ╚═╝╚═╝  ╚══╝   ╚═╝   ╚═╝╚═╝     ╚═╝",
            }

            dashboard.body.content = {
                { "    New File", "lua require'startup'.new_file()", "<leader>nf" },
                { "🖿    File Explorer", "Explore", "<leader>fe" },
                { "☰    Marked Files", 'lua require("harpoon.ui").toggle_quick_menu()', "<leader>hm" },
                { "    Git Status", "Git", "<leader>gs" },
                { "    Find File", "Telescope find_files", "<leader>ff" },
                { "󰍉    Find Word", "Telescope live_grep", "<leader>lg" },
                { "    Recent Files", "Telescope oldfiles", "<leader>of" },
            }

            startup.setup(dashboard)
        end,
    })
end)
