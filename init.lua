---@diagnostic disable: undefined-global

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)

vim.g.mapleader = " "
vim.g.maplocalleader = "  "

vim.opt.shada = ""

vim.o.cindent = true
vim.cmd([[autocmd FileType cpp setlocal cindent]])

vim.g.have_nerd_font = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.termguicolors = true
vim.opt.guicursor = "n-v-c:block"

vim.opt.clipboard = "unnamedplus"

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.breakindent = true

vim.opt.signcolumn = "yes"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.o.background = "dark"
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.smartcase = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("USERPROFILE") .. "/vimfiles/undodir"
vim.opt.undofile = true
vim.opt.scrolloff = 0
vim.opt.updatetime = 50
vim.opt.completeopt = { "menuone", "noselect" }
vim.cmd([[set iskeyword+=-]])
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })

--vim.opt.syntax = 'on'
vim.opt.wrap = true
vim.opt.timeoutlen = 300
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.inccommand = "split"
--
--
--
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<C-h>", "<C-w><C-h>")
vim.keymap.set("n", "<C-l>", "<C-w><C-l>")
vim.keymap.set("n", "<C-j>", "<C-w><C-j>")
vim.keymap.set("n", "<C-k>", "<C-w><C-k>")
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>")
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>")
vim.keymap.set("n", "<C-Right>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<C-Left>", ":vertical resize +2<CR>")
vim.api.nvim_set_keymap("n", "<C-E>", "7<C-E>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-Y>", "7<C-Y>", { noremap = true, silent = true })

-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.api.nvim_set_keymap("n", "^", "0", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "0", "^", { noremap = true, silent = true })

vim.api.nvim_set_keymap("v", "p", '"_dP', {})
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		{ --which-key
			"folke/which-key.nvim",
			event = "VeryLazy",
			opts = {
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			},
			keys = {
				{
					"<leader>?",
					function()
						require("which-key").show({ global = false })
					end,
					desc = "Buffer Local Keymaps (which-key)",
				},
			},
		},

		{ --comment.nvim
			"numToStr/Comment.nvim",
			opts = {
				-- add any options here
			},
		},

		{ --auto-session
			"rmagatti/auto-session",
			lazy = false,
			dependencies = {
				"nvim-telescope/telescope.nvim", -- Only needed if you want to use sesssion lens
			},
			config = function()
				require("auto-session").setup({
					auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
					bypass_session_save_file_types = nil, -- table: Bypass auto save when only buffer open is one of these file types
					close_unsupported_windows = true, -- boolean: Close windows that aren't backed by normal file
					cwd_change_handling = { -- table: Config for handling the DirChangePre and DirChanged autocmds, can be set to nil to disable altogether
						restore_upcoming_session = false, -- boolean: restore session for upcoming cwd on cwd change
						pre_cwd_changed_hook = nil, -- function: This is called after auto_session code runs for the `DirChangedPre` autocmd
						post_cwd_changed_hook = nil, -- function: This is called after auto_session code runs for the `DirChanged` autocmd
					},
					args_allow_single_directory = true, -- boolean Follow normal sesion save/load logic if launched with a single directory as the only argument
					args_allow_files_auto_save = false, -- boolean|function Allow saving a session even when launched with a file argument (or multiple files/dirs).
				})
			end,
		},

		{ --autopairs
			"windwp/nvim-autopairs",
			event = "InsertEnter",
			config = true,
			opts = {
				{
					disable_filetype = { "TelescopePrompt", "spectre_panel" },
					disable_in_macro = true, -- disable when recording or executing a macro
					disable_in_visualblock = false, -- disable when insert after visual block mode
					disable_in_replace_mode = true,
					ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
					enable_moveright = true,
					enable_afterquote = true, -- add bracket pairs after quote
					enable_check_bracket_line = true, --- check bracket in same line
					enable_bracket_in_quote = true, --
					enable_abbr = false, -- trigger abbreviation
					break_undo = true, -- switch for basic rule break undo sequence
					check_ts = false,
					map_cr = false,
					map_bs = true, -- map the <BS> key
					map_c_h = false, -- Map the <C-h> key to delete a pair
					map_c_w = false, -- map <c-w> to delete a pair if possible
				},
			},
		},

		{ --gruvbox
			"ellisonleao/gruvbox.nvim",
			priority = 1000,
			config = true,
			opts = ...,
		},

		{ --todo-comments
			"folke/todo-comments.nvim",
			dependencies = { "nvim-lua/plenary.nvim" },
			opts = {
				vim.keymap.set("n", "]t", function()
					require("todo-comments").jump_next()
				end, { desc = "Next todo comment" }),

				vim.keymap.set("n", "[t", function()
					require("todo-comments").jump_prev()
				end, { desc = "Previous todo comment" }),

				vim.keymap.set("n", "]t", function()
					require("todo-comments").jump_next({ keywords = { "ERROR", "WARNING" } })
				end, { desc = "Next error/warning todo comment" }),
			},
		},

		{ --nvim-treesitter
			"nvim-treesitter/nvim-treesitter",
			build = ":TSUpdate",
			opts = {
				ensure_installed = { "c", "cpp", "lua" },
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
			},

			config = function(_, opts)
				require("nvim-treesitter.install").prefer_git = false
				require("nvim-treesitter.install").compilers = { "clang", "gcc" }
				---@diagnostic disable-next-line: missing-fields
				require("nvim-treesitter.configs").setup(opts)
			end,
		},

		{ --telescope
			"nvim-telescope/telescope.nvim",
			event = "VimEnter",
			branch = "0.1.x",
			dependencies = {
				"nvim-lua/plenary.nvim",
				{ -- If encountering errors, see telescope-fzf-native README for installation instructions
					"nvim-telescope/telescope-fzf-native.nvim",

					build = "make",

					cond = function()
						return vim.fn.executable("make") == 1
					end,
				},
				{ "nvim-telescope/telescope-ui-select.nvim" },

				-- Useful for getting pretty icons, but requires a Nerd Font.
				{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
			},
			config = function()
				require("telescope").setup({
					-- defaults = {
					--   mappings = {
					["<C-y>"] = require("telescope-undo.actions").yank_deletions,
					["<C-r>"] = require("telescope-undo.actions").restore,
					--     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
					--   },
					-- },
					-- pickers = {}
					extensions = {
						["ui-select"] = {
							require("telescope.themes").get_dropdown(),
						},
					},
				})
				pcall(require("telescope").load_extension, "fzf")
				pcall(require("telescope").load_extension, "ui-select")
				local builtin = require("telescope.builtin")
				vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
				vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
				vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
				vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
				vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
				vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
				vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
				vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
				vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
				vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

				vim.keymap.set("n", "<leader>/", function()
					-- You can pass additional configuration to Telescope to change the theme, layout, etc.
					builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
						winblend = 10,
						previewer = false,
					}))
				end, { desc = "[/] Fuzzily search in current buffer" })

				vim.keymap.set("n", "<leader>s/", function()
					builtin.live_grep({
						grep_open_files = true,
						prompt_title = "Live Grep in Open Files",
					})
				end, { desc = "[S]earch [/] in Open Files" })

				vim.keymap.set("n", "<leader>sn", function()
					builtin.find_files({ cwd = vim.fn.stdpath("config") })
				end, { desc = "[S]earch [N]eovim files" })
			end,
		},

		{ --telescope-undo
			"debugloop/telescope-undo.nvim",
			dependencies = { -- note how they're inverted to above example
				{
					"nvim-telescope/telescope.nvim",
					dependencies = { "nvim-lua/plenary.nvim" },
				},
			},
			keys = {
				{ -- lazy style key map
					"<leader>u",
					"<cmd>Telescope undo<cr>",
					desc = "undo history",
				},
			},
			opts = {
				-- don't use `defaults = { }` here, do this in the main telescope spec
				extensions = {
					undo = {
						-- telescope-undo.nvim config, see below
					},
					-- no other extensions here, they can have their own spec too
				},
			},
			config = function(_, opts)
				-- Calling telescope's setup from multiple specs does not hurt, it will happily merge the
				-- configs for us. We won't use data, as everything is in it's own namespace (telescope
				-- defaults, as well as each extension).
				require("telescope").setup(opts)
				require("telescope").load_extension("undo")
			end,
		},

		{ --mason,mason-lspconfig,tool-installer,nvim-lspconfig, fidget, lazydev, luvit
			"neovim/nvim-lspconfig",
			dependencies = {
				-- Automatically install LSPs and related tools to stdpath for Neovim
				{ "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
				"williamboman/mason-lspconfig.nvim",
				"WhoIsSethDaniel/mason-tool-installer.nvim",

				{ "j-hui/fidget.nvim", opts = {} },

				-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
				-- used for completion, annotations and signatures of Neovim apis
				{
					"folke/lazydev.nvim",
					ft = "lua",
					opts = {
						library = {
							-- Load luvit types when the `vim.uv` word is found
							{ path = "luvit-meta/library", words = { "vim%.uv" } },
						},
					},
				},
				{ "Bilal2453/luvit-meta", lazy = true },
			},
			config = function()
				vim.api.nvim_create_autocmd("LspAttach", {
					group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
					callback = function(event)
						local map = function(keys, func, desc)
							vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
						end

						-- Jump to the definition of the word under your cursor.
						--  This is where a variable was first declared, or where a function is defined, etc.
						--  To jump back, press <C-t>.
						map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

						-- Find references for the word under your cursor.
						map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

						-- Jump to the implementation of the word under your cursor.
						--  Useful when your language has ways of declaring types without an actual implementation.
						map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

						-- Jump to the type of the word under your cursor.
						--  Useful when you're not sure what type a variable is and you want to see
						--  the definition of its *type*, not where it was *defined*.
						map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

						-- Fuzzy find all the symbols in your current document.
						--  Symbols are things like variables, functions, types, etc.
						map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

						-- Fuzzy find all the symbols in your current workspace.
						--  Similar to document symbols, except searches over your entire project.
						map(
							"<leader>ws",
							require("telescope.builtin").lsp_dynamic_workspace_symbols,
							"[W]orkspace [S]ymbols"
						)

						-- Rename the variable under your cursor.
						--  Most Language Servers support renaming across files, etc.
						map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

						-- Execute a code action, usually your cursor needs to be on top of an error
						-- or a suggestion from your LSP for this to activate.
						map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

						-- WARN: This is not Goto Definition, this is Goto Declaration.
						--  For example, in C this would take you to the header.
						map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

						local client = vim.lsp.get_client_by_id(event.data.client_id)
						if
							client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight)
						then
							local highlight_augroup =
								vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
							vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
								buffer = event.buf,
								group = highlight_augroup,
								callback = vim.lsp.buf.document_highlight,
							})

							vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
								buffer = event.buf,
								group = highlight_augroup,
								callback = vim.lsp.buf.clear_references,
							})

							vim.api.nvim_create_autocmd("LspDetach", {
								group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
								callback = function(event2)
									vim.lsp.buf.clear_references()
									vim.api.nvim_clear_autocmds({
										group = "kickstart-lsp-highlight",
										buffer = event2.buf,
									})
								end,
							})
						end

						-- The following code creates a keymap to toggle inlay hints in your
						-- code, if the language server you are using supports them
						--
						-- This may be unwanted, since they displace some of your code
						if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
							map("<leader>th", function()
								vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
							end, "[T]oggle Inlay [H]ints")
						end
					end,
				})
			end,
		},

		{ --conform
			"stevearc/conform.nvim",
			event = { "BufWritePre" },
			cmd = { "ConformInfo" },
			keys = {
				{
					"<leader>f",
					function()
						require("conform").format({ async = true, lsp_fallback = true })
					end,
					mode = "",
					desc = "[F]ormat buffer",
				},
			},
			opts = {
				notify_on_error = false,
				format_on_save = function(bufnr)
					local disable_filetypes = { c = false, cpp = false }
					return {
						timeout_ms = 500,
						lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
					}
				end,
				formatters_by_ft = {
					c = { "clang-format" },
					cpp = { "clang-format" },
					lua = { "stylua" },
				},
			},
		},

		{ --mini.nvim
			"echasnovski/mini.nvim",
			config = function()
				-- Better Around/Inside textobjects
				--
				-- Examples:
				--  - va)  - [V]isually select [A]round [)]paren
				--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
				--  - ci'  - [C]hange [I]nside [']quote
				require("mini.ai").setup({ n_lines = 500 })

				-- Add/delete/replace surroundings (brackets, quotes, etc.)
				--
				-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
				-- - sd'   - [S]urround [D]elete [']quotes
				-- - sr)'  - [S]urround [R]eplace [)] [']
				require("mini.surround").setup()

				-- Simple and easy statusline.
				--  You could remove this setup call if you don't like it,
				--  and try some other statusline plugin

				local statusline = require("mini.statusline")
				-- set use_icons to true if you have a Nerd Font
				statusline.setup({ use_icons = vim.g.have_nerd_font })

				-- You can configure sections in the statusline by overriding their
				-- default behavior. For example, here we set the section for
				-- cursor location to LINE:COLUMN
				---@diagnostic disable-next-line: duplicate-set-field
				statusline.section_location = function()
					return "%2l:%-2v"
				end
			end,
		},

		{ --lualine
			"nvim-lualine/lualine.nvim",
			dependencies = { "nvim-tree/nvim-web-devicons" },
		},

		{ --nvim-ufo
			"kevinhwang91/nvim-ufo",
			dependencies = {
				"kevinhwang91/promise-async",
			},

			config = function()
				local capabilities = vim.lsp.protocol.make_client_capabilities()
				capabilities.textDocument.foldingRange = {
					dynamicRegistration = false,
					lineFoldingOnly = true,
				}
				local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
				for _, ls in ipairs(language_servers) do
					require("lspconfig")[ls].setup({
						capabilities = capabilities,
						-- you can add other fields for setting up lsp server in this table
					})
				end

				vim.o.foldcolumn = "0" -- '0' is not bad
				vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
				vim.o.foldlevelstart = 99
				vim.o.foldenable = true

				vim.o.fillchars = [[eob: ,fold: ,foldopen:▼,foldsep: ,foldclose:⏵]]

				vim.keymap.set("n", "zR", require("ufo").openAllFolds)
				vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
				vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
				vim.keymap.set("n", "zm", require("ufo").closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
				vim.keymap.set("n", "K", function()
					local winid = require("ufo").peekFoldedLinesUnderCursor()
					if not winid then
						-- choose one of coc.nvim and nvim lsp
						vim.fn.CocActionAsync("definitionHover") -- coc.nvim
						vim.lsp.buf.hover()
					end
				end)

				require("ufo").setup()
			end,
		},
	},

	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "clangd" },
})
require("mason-tool-installer").setup({
	ensure_installed = {
		"stylua",
		"clang-format",
	},
	integrations = {
		["mason-lspconfig"] = true,
	},
})
require("lspconfig").clangd.setup({})
require("lspconfig").lua_ls.setup({})

require("lualine").setup({
	options = {
		theme = "gruvbox",
		section_separators = "",
		component_separators = "",
	},
	...,
})

require("Comment").setup()

require("which-key").add({
	{ "<leader>f", group = "file" }, -- group
	{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File", mode = "n" },
	{
		"<leader>fb",
		function()
			print("hello")
		end,
		desc = "Foobar",
	},
	{ "<leader>fn", desc = "New File" },
	{ "<leader>f1", hidden = true }, -- hide this keymap
	{ "<leader>w", proxy = "<c-w>", group = "windows" }, -- proxy to window mappings
	{
		"<leader>b",
		group = "buffers",
		expand = function()
			return require("which-key.extras").expand.buf()
		end,
	},
	{
		-- Nested mappings are allowed and can be added in any order
		-- Most attributes can be inherited or overridden on any level
		-- There's no limit to the depth of nesting
		mode = { "n", "v" }, -- NORMAL and VISUAL mode
		{ "<leader>q", "<cmd>q<cr>", desc = "Quit" }, -- no need to specify mode since it's inherited
		{ "<leader>w", "<cmd>w<cr>", desc = "Write" },
	},
})

require("gruvbox").setup({
	terminal_colors = true, -- add neovim terminal colors
	undercurl = true,
	underline = true,
	bold = true,
	italic = {
		strings = true,
		emphasis = true,
		comments = true,
		operators = false,
		folds = true,
	},
	strikethrough = true,
	invert_selection = false,
	invert_signs = false,
	invert_tabline = false,
	invert_intend_guides = false,
	inverse = true, -- invert background for search, diffs, statuslines and errors
	contrast = "", -- can be "hard", "soft" or empty string
	palette_overrides = {},
	overrides = {},
	dim_inactive = false,
	transparent_mode = false,
})
vim.cmd("colorscheme gruvbox")
-- vim.api.nvim_set_hl(0, "MySignColumnGroup", { bg = "#282828" })
-- vim.api.nvim_set_hl(0, "SignColumn", { bg = "#282828" })
-- vim.api.nvim_set_hl(0, "FoldColumn", { bg = "#282828" })
vim.api.nvim_set_hl(0, "MySignColumnGroup", { bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
vim.api.nvim_set_hl(0, "FoldColumn", { bg = "none" })

vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none" })

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
