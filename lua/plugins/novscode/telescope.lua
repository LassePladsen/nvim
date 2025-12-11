return { -- Fuzzy Finder (files, lsp, etc)
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
		{ "debugloop/telescope-undo.nvim" },

		-- Useful for getting pretty icons, but requires a Nerd Font.
		-- { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		{ "echasnovski/mini.icons", opts = {}, enabled = vim.g.have_nerd_font },
	},
	config = function()
		require("telescope").setup({
			defaults = {
				layout_strategy = "vertical",
				layout_config = { height = 0.95, width = 0.95, vertical = { preview_height = 0.6 } },
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
				fzf = {},
			},
		})

		-- Enable Telescope extensions if they are installed
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")
		pcall(require("telescope").load_extension, "undo")

		local builtin = require("telescope.builtin")
		local utils = require("telescope.utils")
		vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
		vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
		vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [f]iles" })
		vim.keymap.set("n", "<leader>sF", function()
			builtin.find_files({ cwd = utils.buffer_dir() })
		end, { desc = "[S]earch [F]iles in buffer cwd" })
		vim.keymap.set("n", "<leader>st", builtin.git_files, { desc = "[S]earch gi[T] files" })
		vim.keymap.set("n", "<leader>sT", builtin.builtin, { desc = "[S]earch [T]elescope" })
		vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
		vim.keymap.set("n", "<leader>sm", builtin.marks, { desc = "[S]earch [M]arks" })
		vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
		vim.keymap.set("n", "<F5>", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
		vim.keymap.set("n", "<leader><leader>", builtin.resume, { desc = "Search resume" })
		vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
		vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "[S]earch buffers" })
		vim.keymap.set("n", "<leader>sr", builtin.registers, { desc = "[S]earch [R]egisters" })
		vim.keymap.set("n", "<leader>sj", builtin.jumplist, { desc = "[S]earch [j]umplist" })
		vim.keymap.set("n", "<leader>sc", builtin.command_history, { desc = "[S]earch [c]ommand history" })
		vim.keymap.set("n", "<leader>sh", builtin.search_history, { desc = "[S]earch [h]istory" })
		vim.keymap.set("n", "<leader>gc", builtin.git_commits, { desc = "[g]it [c]ommits" })
		vim.keymap.set("n", "<leader>gl", builtin.git_commits, { desc = "[g]it [l]og" })
		vim.keymap.set("n", "<leader>su", "<cmd>Telescope undo<cr>", { desc = "[S]earch [u]ndo history" })
		-- vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep in project" })

		-- Custom telescope live grep that supports file matching after a double space e.g. "pattern  *.tsx"
		vim.keymap.set(
			"n",
			"<leader>sg",
			require("config.telescope.multigrep").start,
			{ desc = "[S]earch by [G]rep in project cwd" }
		)
		-- same as above, but in buffers cwd
		vim.keymap.set("n", "<leader>sG", function()
			require("config.telescope.multigrep").start({ cwd = utils.buffer_dir() })
		end, { desc = "[S]earch by [G]rep in buffer cwd" })

		-- Slightly advanced example of overriding default behavior and theme
		vim.keymap.set("n", "<leader>/", function()
			-- You can pass additional configuration to Telescope to change the theme, layout, etc.
			builtin.current_buffer_fuzzy_find(
				-- require("telescope.themes").get_dropdown({
				-- 	winblend = 10,
				-- 	previewer = true,
				-- })
			)
		end, { desc = "[/] Fuzzily search in current buffer" })

		vim.keymap.set("n", "<leader>s/", function()
			builtin.live_grep({
				grep_open_files = true,
				prompt_title = "Live Grep in Open Files",
			})
		end, { desc = "[S]earch [/] in Open Files" })

		-- Shortcut for searching your Neovim configuration files
		vim.keymap.set("n", "<leader>sn", function()
			builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end, { desc = "[S]earch [N]eovim files" })

		-- Shortcut for grepping your Neovim configuration
		vim.keymap.set("n", "<leader>sN", function()
			require("config.telescope.multigrep").start({ cwd = vim.fn.stdpath("config") })
		end, { desc = "[S]earch by grep in [N]eovim files" })
	end,
}
