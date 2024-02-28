-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

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

		config = function()
			require("rose-pine").setup({
				variant = "auto", -- auto, main, moon, or dawn
				dark_variant = "main", -- main, moon, or dawn
				dim_inactive_windows = false,
				extend_background_behind_borders = true,

				enable = {
					terminal = true,
					legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
					migrations = true, -- Handle deprecated options automatically
				},

				styles = {
					bold = false,
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
					note = "pine",
					todo = "rose",
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

					h1 = "iris",
					h2 = "foam",
					h3 = "rose",
					h4 = "gold",
					h5 = "pine",
					h6 = "foam",
				},

				highlight_groups = {
					-- Comment = { fg = "foam" },
					-- VertSplit = { fg = "muted", bg = "muted" },
				},

				before_highlight = function(group, highlight, palette)
					-- Disable all undercurls
					-- if highlight.undercurl then
					--     highlight.undercurl = false
					-- end
					--
					-- Change palette colour
					-- if highlight.fg == palette.pine then
					--     highlight.fg = palette.foam
					-- end
				end,
			})

			local themes = {
				"rose-pine-moon",
				"rose-pine-main",
				"rose-pine-dawn",
				"tokyonight-night",
				"tokyonight-storm",
				"tokyonight-day",
				"tokyonight-moon",
			}

			local function ColorMyPencils(themeIndex)
				local theme = themes[themeIndex] or themes[1]
				vim.cmd.colorscheme(theme)
				vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
				vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
			end

			for i = 1, #themes do
				vim.keymap.set("n", "<leader>cs" .. i, function()
					ColorMyPencils(i)
				end)
			end

			ColorMyPencils()
		end,
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

		config = function()
			require("nvim-treesitter").setup({
				-- A list of parser names, or "all" (the five listed parsers should always be installed)
				ensure_installed = { "javascript", "typescript", "c", "lua", "vim", "vimdoc", "query" },

				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,

				-- Automatically install missing parsers when entering buffer
				-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
				auto_install = true,

				highlight = {
					enable = true,

					-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
					-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
					-- Using this option may slow down your editor, and you may see some duplicate highlights.
					-- Instead of true it can also be a list of languages
					additional_vim_regex_highlighting = false,
				},
			})
		end,
	}, { run = ":TSUpdate" })

	use({
		"ThePrimeagen/harpoon",

		config = function()
			local ui = require("harpoon.ui")
			local term = require("harpoon.term")
			local MAXFILES = 5

			require("harpoon").setup({
				menu = {
					width = vim.api.nvim_win_get_width(0) - 4,
				},
			})

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

				config = function()
					vim.api.nvim_create_user_command("SetupLsp", function()
						require("mason-lspconfig").setup({
							-- for lsp
							ensure_installed = {
								"tsserver",
								"pyright",
								"cmake",
								"eslint",
								"svelte",
								"tailwindcss",
								"clangd",
								"jsonls",
								"bashls",
								"emmet_language_server",
								"omnisharp",
								"ltex",
								"lua_ls",
								"html",
								"gopls",
								"dockerls",
								"docker_compose_language_service",
							},
						})
					end, {})
				end,
			}, -- Optional
			{
				"jay-babu/mason-null-ls.nvim",

				requires = { "jose-elias-alvarez/null-ls.nvim" },

				config = function()
					vim.api.nvim_create_user_command("SetupFmt", function()
						require("mason-null-ls").setup({
							-- for formatter
							ensure_installed = {
								"stylua",
								"black",
								"clang-format",
								"prettierd",
							},
						})
					end, {})
				end,
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
			local lsp_zero = require("lsp-zero")

			local lsp_config = require("lspconfig")

			lsp_zero.preset("recommended")

			require("mason-lspconfig").setup({
				handlers = {
					lsp_zero.default_setup,
					eslint = lsp_zero.noop,
					lua_ls = function()
						local lua_opts = lsp_zero.nvim_lua_ls()
						lsp_config.lua_ls.setup(lua_opts)
					end,
				},
			})

			local cmp = require("cmp")
			local cmp_action = lsp_zero.cmp_action()
			require("luasnip.loaders.from_vscode").lazy_load()
			vim.opt.completeopt = { "menu", "menuone", "noselect" }

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
					["<C-d>"] = cmp_action.luasnip_jump_forward(),
					["<C-b>"] = cmp_action.luasnip_jump_backward(),

					-- scroll documentation window
					["<C-f>"] = cmp.mapping.scroll_docs(-5),
					-- ["<C-d>"] = cmp.mapping.scroll_docs(5),
				}),
				sources = {
					{ name = "path" },
					{ name = "nvim_lsp" },
					{ name = "nvim_lua" },
					{ name = "buffer", keyword_length = 3 },
					{ name = "luasnip", keyword_length = 2 },
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				preselect = "item",
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				formatting = lsp_zero.cmp_format(),
			})

			lsp_zero.set_preferences({
				sign_icons = {
					error = "✘",
					warn = "▲",
					hint = "⚑",
					info = "",
				},
			})

			lsp_zero.on_attach(function(client, bufnr)
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

				vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)

				if client.server_capabilities.signatureHelpProvider then
					require("lsp-overloads").setup(client, {
						-- UI options are mostly the same as those passed to vim.lsp_zero.util.open_floating_preview
						ui = {
							border = "single", -- The border to use for the signature popup window. Accepts same border values as |nvim_open_win()|.
							height = nil, -- Height of the signature popup window (nil allows dynamic sizing based on content of the help)
							width = nil, -- Width of the signature popup window (nil allows dynamic sizing based on content of the help)
							wrap = true, -- Wrap long lines
							wrap_at = nil, -- Character to wrap at for computing height when wrap enabled
							max_width = nil, -- Maximum signature popup width
							max_height = nil, -- Maximum signature popup height
							-- Events that will close the signature popup window: use {"CursorMoved", "CursorMovedI", "InsertCharPre"} to hide the window when typing
							close_events = { "CursorMoved", "BufHidden", "InsertLeave" },
							focusable = true, -- Make the popup float focusable
							focus = false, -- If focusable is also true, and this is set to true, navigating through overloads will focus into the popup window (probably not what you want)
							offset_x = 0, -- Horizontal offset of the floating window relative to the cursor position
							offset_y = 0, -- Vertical offset of the floating window relative to the cursor position
							floating_window_above_cur_line = false, -- Attempt to float the popup above the cursor position
							-- (note, if the height of the float would be greater than the space left above the cursor, it will default
							-- to placing the float below the cursor. The max_height option allows for finer tuning of this)
						},
						keymaps = {
							next_signature = "<C-j>",
							previous_signature = "<C-k>",
							next_parameter = "<C-l>",
							previous_parameter = "<C-h>",
							close_signature = "<A-s>",
						},
						display_automatically = true, -- Uses trigger characters to automatically display the signature overloads when typing a method signature
					})
					vim.keymap.set({ "n", "i" }, "<A-s>", vim.cmd.LspOverloadsSignature)
				end
			end)

			lsp_zero.setup()

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
			vim.keymap.set("n", "<A-d>", function()
				vim.diagnostic.open_float(0, { scope = "line" })
			end)
		end,
	})

	use({
		"mhartington/formatter.nvim",

		config = function()
			local util = require("formatter.util")

			require("formatter").setup({
				-- Enable or disable logging
				logging = true,
				-- Set the log level
				log_level = vim.log.levels.WARN,
				filetype = {
					lua = { require("formatter.filetypes.lua").stylua },
					python = { require("formatter.filetypes.python").black },
					c = { require("formatter.filetypes.c").clangformat },
					cpp = { require("formatter.filetypes.cpp").clangformat },
					cs = { require("formatter.filetypes.cs").clangformat },
					go = { require("formatter.filetypes.go").gofmt },
					javascript = { require("formatter.filetypes.javascript").prettierd },
					typescript = { require("formatter.filetypes.typescript").prettierd },
					["*"] = {
						require("formatter.filetypes.any").remove_trailing_whitespace,
						util.copyf(require("formatter.defaults").prettierd),
					},
				},
			})

			vim.keymap.set("n", "<leader>fm", function()
				vim.cmd("Format")
			end)

			vim.keymap.set("n", "<leader>fw", function()
				vim.cmd("FormatWrite")
			end)
		end,
	})

	use({
		"numToStr/Comment.nvim",

		config = function()
			require("Comment").setup({
				--Add a space b/w comment and the line
				padding = true,
				---Whether the cursor should stay at its position
				sticky = true,
				---Lines to be ignored while (un)comment
				ignore = nil,
				---LHS of toggle mappings in NORMAL mode
				toggler = {
					---Line-comment toggle keymap
					line = "gcc",
					---Block-comment toggle keymap
					block = "gbc",
				},
				-- -LHS of operator-pending mappings in NORMAL and VISUAL mode
				opleader = {
					---Line-comment keymap
					line = "gc",
					---Block-comment keymap
					block = "gb",
				},
				---LHS of extra mappings
				extra = {
					---Add comment on the line above
					above = "gcO",
					---Add comment on the line below
					below = "gco",
					---Add comment at the end of line
					eol = "gcA",
				},
				---Enable keybindings
				---NOTE: If given `false` then the plugin won't create any mappings
				mappings = {
					---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
					basic = true,
					---Extra mapping; `gco`, `gcO`, `gcA`
					extra = true,
				},
				---Function to call before (un)comment
				pre_hook = nil,
				---Function to call after (un)comment
				post_hook = nil,
			})
		end,
	})

	use({
		"gelguy/wilder.nvim",

		config = function()
			local wilder = require("wilder")

			wilder.setup({
				modes = { ":", "/", "?" },
				next_key = "<Tab>",
				previous_key = "<S-Tab>",
				accept_key = "<Down>",
				reject_key = "<Up>",
				enable_cmdline_enter = 0,
			})

			wilder.set_option(
				"renderer",
				wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
					highlights = {
						border = "Normal", -- highlight to use for the border
					},
					-- 'single', 'double', 'rounded' or 'solid'
					-- can also be a list of 8 characters, see :h wilder#popupmenu_border_theme() for more details
					border = "rounded",
					highlighter = wilder.basic_highlighter(),
					min_width = "auto", -- minimum height of the popupmenu, can also be a number
					min_height = "50%", -- to set a fixed height, set max_height to the same value
					reverse = 0, -- if 1, shows the candidates from bottom to top
				}))
			)
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
					{ "nvim-lua/plenary.nvim" },
					{
						"folke/trouble.nvim",

						requires = {
							{
								"nvim-lualine/lualine.nvim",

								requires = {
									"nvim-tree/nvim-web-devicons",

									config = function()
										require("nvim-web-devicons").setup({
											-- your personnal icons can go here (to override)
											-- you can specify color or cterm_color instead of specifying both of them
											-- DevIcon will be appended to `name`
											override = {
												zsh = {
													icon = "",
													color = "#428850",
													cterm_color = "65",
													name = "Zsh",
												},
											},
											-- globally enable different highlight colors per icon (default to true)
											-- if set to false all icons will have the default icon's color
											color_icons = true,
											-- globally enable default icons (default to false)
											-- will get overriden by `get_icons` option
											default = true,
											-- globally enable "strict" selection of icons - icon will be looked up in
											-- different tables, first by filename, and if not found by extension; this
											-- prevents cases when file doesn't have any extension but still gets some icon
											-- because its name happened to match some extension (default to false)
											strict = true,
											-- same as `override` but specifically for overrides by filename
											-- takes effect when `strict` is true
											override_by_filename = {
												[".gitignore"] = {
													icon = "",
													color = "#f1502f",
													name = "Gitignore",
												},
											},
											-- same as `override` but specifically for overrides by extension
											-- takes effect when `strict` is true
											override_by_extension = {
												["log"] = {
													icon = "",
													color = "#81e043",
													name = "Log",
												},
											},
										})
									end,
								},

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
							},
						},

						config = function()
							local trouble = require("trouble")

							trouble.setup()

							vim.keymap.set("n", "<leader>xx", trouble.toggle)
							vim.keymap.set("n", "<leader>xw", function()
								trouble.toggle("workspace_diagnostics")
							end)
							vim.keymap.set("n", "<leader>xd", function()
								trouble.toggle("document_diagnostics")
							end)
							vim.keymap.set("n", "<leader>xq", function()
								trouble.toggle("quickfix")
							end)
							vim.keymap.set("n", "<leader>xl", function()
								trouble.toggle("loclist")
							end)
							vim.keymap.set("n", "gR", function()
								trouble.toggle("lsp_references")
							end)
						end,
					},
				},

				config = function()
					local telescope = require("telescope")
					local builtin = require("telescope.builtin")
					local trouble = require("trouble.providers.telescope")

					vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
					vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
					vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
					vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
					vim.keymap.set("n", "<leader>gf", builtin.git_files, {})

					telescope.setup({
						defaults = {
							mappings = {
								i = { ["<C-t>"] = trouble.open_with_trouble },
								n = { ["<C-t>"] = trouble.open_with_trouble },
							},
						},
					})
				end,
			},
		},
		config = function()
			local dashboard = require("startup.themes.dashboard")

			dashboard.header.content = {
				"████████╗████████╗██████╗    ███╗  ██╗██╗   ██╗██╗███╗   ███╗",
				"╚══██╔══╝╚══██╔══╝██╔══██╗   ████╗ ██║██║   ██║██║████╗ ████║",
				"   ██║      ██║   ██████╦╝   ██╔██╗██║╚██╗ ██╔╝██║██╔████╔██║",
				"   ██║      ██║   ██╔══██╗   ██║╚████║ ╚████╔╝ ██║██║╚██╔╝██║",
				"   ██║      ██║   ██████╦╝██╗██║ ╚███║  ╚██╔╝  ██║██║ ╚═╝ ██║",
				"   ╚═╝      ╚═╝   ╚═════╝ ╚═╝╚═╝  ╚══╝   ╚═╝   ╚═╝╚═╝     ╚═╝",
			}

			require("startup").setup(dashboard)
		end,
	})
end)
