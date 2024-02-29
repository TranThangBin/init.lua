-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

require("packer")

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	use({
		"rose-pine/neovim",

		requires = {
			{
				"folke/tokyonight.nvim",
				lazy = false,
				priority = 1000,
				opts = {},
			},
		},

		config = require("configs.rose-pine"),
	})

	use({
		"nvim-treesitter/nvim-treesitter",

		requires = {
			{ "nvim-treesitter/playground" },
			{
				"windwp/nvim-ts-autotag",

				config = function()
					require("nvim-ts-autotag").setup()
				end,
			},
		},

		config = require("configs.treesitter"),
	}, { run = ":TSUpdate" })

	use({
		"ThePrimeagen/harpoon",

		config = require("configs.harpoon").setup,
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
		"mhartington/formatter.nvim",

		config = require("configs.formatter").setup,
	})

	use({
		"numToStr/Comment.nvim",

		config = require("configs.comment").setup,
	})

	use({
		"gelguy/wilder.nvim",

		config = require("configs.wilder").setup,
	})

	use({
		"prichrd/netrw.nvim",

		config = require("configs.netrw").setup,
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
		config = function()
			local apm = require("vim-apm")
			apm:setup({})
			vim.keymap.set("n", "<leader>apm", function()
				apm:toggle_monitor()
			end)
		end,
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

	use("ThePrimeagen/vim-be-good")

	use({
		"startup-nvim/startup.nvim",

		requires = {
			{
				"nvim-telescope/telescope.nvim",

				requires = {
					{
						"folke/trouble.nvim",

						requires = {
							{
								"nvim-lualine/lualine.nvim",

								requires = {
									{
										"nvim-tree/nvim-web-devicons",

										config = require("configs.devicons").setup,
									},

									{ "nvim-lua/plenary.nvim" },
								},

								config = require("configs.lualine").setup,
							},
						},

						config = require("configs.trouble").setup,
					},
				},

				config = require("configs.telescope").setup,
			},
		},
		config = require("configs.startup").setup,
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
					require("mason").setup({
						ui = {
							icons = {
								package_installed = "✓",
								package_pending = "➜",
								package_uninstalled = "✗",
							},
						},
					})
				end,
			}, -- Optional
			{
				"williamboman/mason-lspconfig.nvim",

				config = require("configs.mason-lspconfig").ensure_installed,
			}, -- Optional
			{
				"jay-babu/mason-null-ls.nvim",

				requires = { "jose-elias-alvarez/null-ls.nvim" },

				config = require("configs.mason-null-ls").ensure_installed,
			}, -- Optional
			{ "Issafalcon/lsp-overloads.nvim" }, -- Optional

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" }, -- Required
			{ "hrsh7th/cmp-nvim-lsp" }, -- Required
			{ "hrsh7th/cmp-buffer" }, -- Optional
			{ "hrsh7th/cmp-path" }, -- Optional
			{ "saadparwaiz1/cmp_luasnip" }, -- Optional
			{ "hrsh7th/cmp-nvim-lua" }, -- Optional

			-- Snippets
			{ "L3MON4D3/LuaSnip" }, -- Required
			{ "rafamadriz/friendly-snippets" }, -- Optional
		},

		config = function()
			require("configs.lsp-zero").setup()
		end,
	})
end)
