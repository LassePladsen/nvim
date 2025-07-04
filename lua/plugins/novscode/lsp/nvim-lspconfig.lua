return {
	-- Main LSP Configuration
	"neovim/nvim-lspconfig",
	dependencies = {
		-- Automatically install LSPs and related tools to stdpath for Neovim
		-- Mason must be loaded before its dependents so we need to set it up here.
		-- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
		{ "williamboman/mason.nvim", opts = {} },
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		-- Useful status updates for LSP.
		-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
		{ "j-hui/fidget.nvim", opts = {} },

		-- Allows extra capabilities provided by nvim-cmp
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				-- NOTE: Remember that Lua is a real programming language, and as such it is possible
				-- to define small helper and utility functions so you don't have to repeat yourself.
				--
				-- In this case, we create a function that lets us more easily define mappings specific
				-- for LSP related items. It sets the mode, buffer and description for us each time.
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				local telescope = require("telescope.builtin")

				-- Jump to the definition of the word under your cursor.
				--  This is where a variable was first declared, or where a function is defined, etc.
				--  To jump back, press <C-t>.
				map("gd", telescope.lsp_definitions, "[G]oto [D]efinition")

				-- Find references for the word under your cursor.
				map("gr", telescope.lsp_references, "[G]oto [R]eferences")

				-- Jump to the implementation of the word under your cursor.
				--  Useful when your language has ways of declaring types without an actual implementation.
				map("gI", telescope.lsp_implementations, "[G]oto [I]mplementation")

				-- Jump to the type of the word under your cursor.
				--  Useful when you're not sure what type a variable is and you want to see
				--  the definition of its *type*, not where it was *defined*.
				-- map("<leader>D", telescope.lsp_type_definitions, "Type [D]efinition")

				-- Fuzzy find all the symbols in your current document.
				--  Symbols are things like variables, functions, types, etc.
				map("<leader>ssd", telescope.lsp_document_symbols, "[D]ocument [S]ymbols")

				-- Fuzzy find all the symbols in your current workspace.
				--  Similar to document symbols, except searches over your entire project.
				map("<leader>ssw", telescope.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
				-- Rename the variable under your cursor.
				--  Most Language Servers support renaming across files, etc.

				local rename_from_start = function() -- not sure if this is what bugged out my rename. I dont think so
					vim.ui.input({ prompt = "New name: " }, function(input)
						if input then
							vim.lsp.buf.rename(input)
						end
					end)
				end
				map("<leader>rn", rename_from_start, "[R]e[n]ame")
				map("<F2>", rename_from_start, "[R]e[n]ame")
				map("<leader><F2>", vim.lsp.buf.rename, "[R]e[n]ame")

				-- Execute a code action, usually your cursor needs to be on top of an error
				-- or a suggestion from your LSP for this to activate.
				-- map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
				map("<F4>", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })

				-- WARN: This is not Goto Definition, this is Goto Declaration.
				--  For example, in C this would take you to the header.
				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

				map("K", vim.lsp.buf.hover, "Hover definition")
				map("gs", vim.lsp.buf.signature_help, "[Go]to [S]ignature help")

				-- The following two autocommands are used to highlight references of the
				-- word under your cursor when your cursor rests there for a little while.
				--    See `:help CursorHold` for information about when this is executed
				--
				-- When you move your cursor, the highlights will be cleared (the second autocommand).
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
					local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
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
							vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
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

		-- error & warning virtual text as line below
		local diagnostic_config = {
			virtual_text = true,
			-- virtual_lines = { current_line = true },
			virtual_lines = false,
		}

		-- Change diagnostic symbols in the sign column (gutter)
		if true or vim.g.have_nerd_font then -- override, this is nil for some reason...
			local signs = { ERROR = "", WARN = "", INFO = "", HINT = "" }
			local diagnostic_signs = {}
			for type, icon in pairs(signs) do
				diagnostic_signs[vim.diagnostic.severity[type]] = icon
			end
			diagnostic_config.signs = { text = diagnostic_signs }

		end

		vim.diagnostic.config(diagnostic_config)

		-- LSP servers and clients are able to communicate to each other what features they support.
		--  By default, Neovim doesn't support everything that is in the LSP specification.
		--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
		--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		-- Enable the following language servers
		--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
		--
		--  Add any additional override configuration in the following tables. Available keys are:
		--  - cmd (table): Override the default command used to start the server
		--  - filetypes (table): Override the default list of associated filetypes for the server
		--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
		--  - settings (table): Override the default settings passed when initializing the server.
		--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
		local servers = {
			-- clangd = {},
			-- gopls = {},

			pyright = {},
			rust_analyzer = {},
			html = {},
			-- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
			--
			-- Some languages (like typescript) have entire language plugins that can be useful:
			--    https://github.com/pmizio/typescript-tools.nvim
			-- LP: using plugin above in typescript-tools.lua
			--
			-- But for many setups, the LSP (`ts_ls`) will work just fine
			-- ts_ls = {},
			--
			-- phpactor = { -- only works in .git or composer projects........
			-- 	-- root_dir = function()
			-- 	-- 	return vim.loop.cwd()
			-- 	-- end,
			-- 	-- root_uri = function()
			-- 	-- 	return vim.loop.cwd()
			-- 	-- end,
			-- 	-- on_new_config = function(config, root_dir)
			-- 	-- 	config.root_uri = "file://" .. root_dir
			-- 	-- end
			-- },
			intelephense = { -- does not support rename on free version........
				-- root_dir = function()
				-- 	return vim.loop.cwd()
				-- end,
				settings = {
					intelephense = {
						stubs = {
							"bcmath",
							"bz2",
							"calendar",
							"Core",
							"curl",
							"date",
							"dba",
							"dom",
							"enchant",
							"fileinfo",
							"filter",
							"ftp",
							"gd",
							"gettext",
							"hash",
							"iconv",
							"imap",
							"intl",
							"json",
							"ldap",
							"libxml",
							"mbstring",
							"mcrypt",
							"mysql",
							"mysqli",
							"password",
							"pcntl",
							"pcre",
							"PDO",
							"pdo_mysql",
							"Phar",
							"readline",
							"recode",
							"Reflection",
							"regex",
							"session",
							"SimpleXML",
							"soap",
							"sockets",
							"sodium",
							"SPL",
							"standard",
							"superglobals",
							"sysvsem",
							"sysvshm",
							"tokenizer",
							"xml",
							"xdebug",
							"xmlreader",
							"xmlwriter",
							"yaml",
							"zip",
							"zlib",
							"wordpress", --using custom stubs more up to date
							"woocommerce",
							"acf-pro",
							"acf-stubs",
							"wordpress-globals", -- using custom stubs more up to date
							"wp-cli",
							"genesis",
							"polylang",
							"sbi",
							"/home/lasse/.config/composer/vendor/php-stubs"
						},
						-- format = {
						-- 	enable = true,
						-- 	braces = "k&r"
						-- },
					},
				},
			},

			lua_ls = {
				-- cmd = { ... },
				-- filetypes = { ... },
				-- capabilities = {},
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
						-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
						-- diagnostics = { disable = { 'missing-fields' } },
					},
				},
			},
		}

		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, {
			"stylua", -- Used to format Lua code
		})
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					-- This handles overriding only values explicitly passed
					-- by the server configuration above. Useful when disabling
					-- certain features of an LSP (for example, turning off formatting for ts_ls)
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}
