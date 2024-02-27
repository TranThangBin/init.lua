-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.2",
		-- or                            , branch = '0.1.x',
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use({
		"rose-pine/neovim",
		as = "rose-pine",
		-- tag = "v0.1.0", -- Optional tag release
	})
	use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
	use("nvim-treesitter/playground")
	use("ThePrimeagen/harpoon")
	use("mbbill/undotree")
	use("tpope/vim-fugitive")
	use({
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" }, -- Required
			{ "williamboman/mason.nvim" }, -- Optional
			{ "williamboman/mason-lspconfig.nvim" }, -- Optional
			{ "jose-elias-alvarez/null-ls.nvim" }, -- dependency of mason-null-ls
			{ "jay-babu/mason-null-ls.nvim" }, -- Ensure installed formatter

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
	use("mhartington/formatter.nvim")
	use({
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	})
	use("numToStr/Comment.nvim")
	use("gelguy/wilder.nvim")
	use("windwp/nvim-ts-autotag")
	use("Issafalcon/lsp-overloads.nvim")
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons" },
	})
	use("prichrd/netrw.nvim")
	use({
		"LunarWatcher/auto-pairs",
		branch = "develop",
	})
	use("ThePrimeagen/vim-apm")
	use({
		"kylechui/nvim-surround",
		tag = "*",
	})
	use({
		"folke/trouble.nvim",
		requires = { "nvim-tree/nvim-web-devicons" },
	})
	use("ThePrimeagen/vim-be-good")
	use({
		"startup-nvim/startup.nvim",
		requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	})
	use("ColaMint/pokemon.nvim")
end)
