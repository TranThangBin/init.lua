-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd("packadd packer.nvim")

return require("packer").startup(function(use)
	use({
		"wbthomason/packer.nvim",
		"ThePrimeagen/harpoon",
		"ThePrimeagen/vim-be-good",
		"gelguy/wilder.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"nvim-treesitter/playground",
	})

	use({
		"mhartington/formatter.nvim",

		config = function()
			require("formatter").setup(require("configs.formatter-config"))
			vim.keymap.set("n", "<leader>fm", vim.cmd.Format)
		end,
	})

	use({
		"windwp/nvim-autopairs",

		event = "InsertEnter",

		config = function()
			require("nvim-autopairs").setup({})
		end,
	})

	use({
		"folke/trouble.nvim",

		config = function()
			require("trouble").setup(require("configs.trouble-config"))
		end,
	})

	use({
		"folke/zen-mode.nvim",

		config = function()
			require("zen-mode").setup(require("configs.zenmode-config"))
		end,
	})

	use({
		"rose-pine/neovim",

		config = function()
			require("rose-pine").setup(require("configs.rose-pine-config"))
			vim.cmd.colorscheme("rose-pine-moon")
			vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
		end,
	})

	use({
		"folke/tokyonight.nvim",

		config = function()
			require("tokyonight").setup(require("configs.tokyonight-config"))
		end,
	})

	use({
		"nvim-treesitter/nvim-treesitter",

		config = function()
			require("nvim-treesitter.configs").setup(require("configs.treesitter-config"))
		end,
	})

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
			{ "neovim/nvim-lspconfig" }, -- Required
			{
				"williamboman/mason.nvim",

				config = function()
					require("mason").setup(require("configs.mason-config"))
				end,
			}, -- Optional
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
			{ "L3MON4D3/LuaSnip" }, -- Required
			{ "rafamadriz/friendly-snippets" }, -- Optional
		},
	})

	use({
		"numToStr/Comment.nvim",

		config = function()
			require("Comment").setup(require("configs.comment-config"))
		end,
	})

	use({
		"nvim-tree/nvim-web-devicons",

		config = function()
			require("nvim-web-devicons").setup(require("configs.web-devicons-config"))
		end,
	})

	use({
		"nvim-lualine/lualine.nvim",

		config = function()
			require("lualine").setup(require("configs.lualine-config"))
		end,
	})

	use({
		"prichrd/netrw.nvim",

		config = function()
			require("netrw").setup(require("configs.netrw-config"))
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
			require("nvim-surround").setup(require("configs.surround-config"))
		end,
	})

	use({
		"startup-nvim/startup.nvim",

		config = function()
			local startup = require("startup")

			vim.keymap.set("n", "<leader>nf", startup.new_file)

			startup.setup(require("configs.startup-config"))
		end,
	})
end)
