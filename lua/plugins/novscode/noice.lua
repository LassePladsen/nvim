return {
	"folke/noice.nvim",
	event = "VeryLazy",
	enabled = false,
	config = function()
		require("noice").setup( {
		cmdline = {
			view = "cmdline_popup",
			format = {
				cmdline = { pattern = "^:", icon = "", opts = cmdline_opts },
				search_down = { view = "cmdline", kind = "Search", pattern = "^/", icon = "🔎 ", ft = "regex" },
				search_up = { view = "cmdline", kind = "Search", pattern = "^%?", icon = "🔎 ", ft = "regex" },
				input = { icon = "✏️ ", ft = "text", opts = cmdline_opts },
				calculator = { pattern = "^=", icon = "", lang = "vimnormal", opts = cmdline_opts },
				substitute = {
					pattern = "^:%%?s/",
					icon = "🔁",
					ft = "regex",
					opts = { border = { text = { top = " sub (old/new/) " } } },
				},
				filter = { pattern = "^:%s*!", icon = "$", ft = "sh", opts = cmdline_opts },
				filefilter = {
					kind = "Filter",
					pattern = "^:%s*%%%s*!",
					icon = "📄 $",
					ft = "sh",
					opts = cmdline_opts,
				},
				selectionfilter = {
					kind = "Filter",
					pattern = "^:%s*%'<,%'>%s*!",
					icon = " $",
					ft = "sh",
					opts = cmdline_opts,
				},
				lua = { pattern = "^:%s*lua%s+", icon = "", conceal = true, ft = "lua", opts = cmdline_opts },
				rename = {
					pattern = "^:%s*IncRename%s+",
					icon = "✏️ ",
					conceal = true,
					opts = {
						relative = "cursor",
						size = { min_width = 20 },
						position = { row = -3, col = 0 },
						buf_options = { filetype = "text" },
						border = { text = { top = " rename " } },
					},
				},
				help = { pattern = "^:%s*h%s+", icon = "💡", opts = cmdline_opts },
			},
		},
		lsp = {
			-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
			},
		},
		-- you can enable a preset for easier configuration
		presets = {
			bottom_search = true, -- use a classic bottom cmdline for search
			command_palette = true, -- position the cmdline and popupmenu together
			long_message_to_split = true, -- long messages will be sent to a split
			inc_rename = false, -- enables an input dialog for inc-rename.nvim
			lsp_doc_border = false, -- add a border to hover docs and signature help
		},

		views = {
			split = { enter = true },
			mini = { win_options = { winblend = 100 } },
		},

		-- direct some unimportant message to mini (line at bottom) for less invasion
		routes = {
			-- { filter = { find = "E162" }, view = "mini" },
			-- { filter = { event = "msg_show", kind = "", find = "written" }, view = "mini" },
			{ filter = { event = "msg_show", find = "search hit BOTTOM" }, view = "mini" },
			{ filter = { event = "msg_show", find = "search hit TOP" }, view = "mini" },
			-- { filter = { event = "emsg", find = "E23" }, skip = true },
			-- { filter = { event = "emsg", find = "E20" }, skip = true },
			{ filter = { find = "E37" }, skip = true },
		},
	},

	require("notify").setup({
		render = "compact",
		timeout = 2000,
		stages = "static",
	})
		)
	end,
	dependencies = {
		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
		"MunifTanjim/nui.nvim",
		-- OPTIONAL:
		--   `nvim-notify` is only needed, if you want to use the notification view.
		--   If not available, we use `mini` as the fallback
		"rcarriga/nvim-notify",
	},
}
