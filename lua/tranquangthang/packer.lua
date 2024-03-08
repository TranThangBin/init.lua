-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd("packadd packer.nvim")

return require("packer").startup(function(use)
    use("wbthomason/packer.nvim")

    use("nvim-treesitter/playground")

    use("ThePrimeagen/harpoon")

    use("ThePrimeagen/vim-be-good")

    use("gelguy/wilder.nvim")

    use("nvim-lua/plenary.nvim")

    use("nvim-telescope/telescope.nvim")

    use({
        "windwp/nvim-autopairs",

        event = "InsertEnter",

        config = function()
            require("nvim-autopairs").setup({})
        end
    })

    use({
        "folke/trouble.nvim",

        config = function()
            require("trouble").setup(require("configs.trouble-conf"))
        end
    })

    use({
        "folke/zen-mode.nvim",

        config = function()
            require("zen-mode").setup(require("configs.zenmode-conf"))
        end
    })

    use({
        "rose-pine/neovim",

        config = function()
            require("rose-pine").setup(require("configs.rose-pine-conf"))
            vim.cmd.colorscheme("rose-pine-moon")
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        end,
    })

    use({
        "folke/tokyonight.nvim",

        lazy = false,

        priority = 1000,

        opts = {},

        config = function()
            require("tokyonight").setup(require("configs.tokyonight-conf"))
        end
    })

    use({
        "windwp/nvim-ts-autotag",

        requires = {
            {
                "nvim-treesitter/nvim-treesitter",

                config = function()
                    require("nvim-treesitter").setup(
                        require("configs.treesitter-conf")
                    )
                end,

                run = function()
                    require('nvim-treesitter.install').
                        update({ with_sync = true })()
                end,
            }
        },

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
            { "neovim/nvim-lspconfig" }, -- Required
            {
                "williamboman/mason.nvim",

                config = function()
                    require("mason").setup(require("configs.mason-conf"))
                end
            },                                       -- Optional
            { "williamboman/mason-lspconfig.nvim" }, -- Optional
            { "Issafalcon/lsp-overloads.nvim" },

            -- Autocompletion
            { "hrsh7th/nvim-cmp" },         -- Required
            { "hrsh7th/cmp-nvim-lsp" },     -- Required
            { "hrsh7th/cmp-buffer" },       -- Optional
            { "hrsh7th/cmp-path" },         -- Optional
            { "saadparwaiz1/cmp_luasnip" }, -- Optional
            { "hrsh7th/cmp-nvim-lua" },     -- Optional

            -- Snippets
            { "L3MON4D3/LuaSnip" },             -- Required
            { "rafamadriz/friendly-snippets" }, -- Optional
        },
    })

    use({
        "numToStr/Comment.nvim",

        config = function()
            require("Comment").setup(require("configs.comment-conf"))
        end,
    })

    use({
        "nvim-tree/nvim-web-devicons",

        config = function()
            require("nvim-web-devicons").setup(
                require("configs.web-devicons-conf")
            )
        end,
    })

    use({
        "nvim-lualine/lualine.nvim",

        config = function()
            require("lualine").setup(require("configs.lualine-conf"))
        end,
    })

    use({
        "prichrd/netrw.nvim",

        config = function()
            require("netrw").setup(require("configs.netrw-conf"))
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
            require("nvim-surround").setup(require("configs.surround-conf"))
        end,
    })

    use({
        "startup-nvim/startup.nvim",

        config = function()
            local startup = require("startup")

            vim.keymap.set("n", "<leader>nf", startup.new_file)

            startup.setup(require("configs.startup-conf"))
        end,
    })
end)
