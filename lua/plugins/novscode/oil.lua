return {
	"stevearc/oil.nvim",
	keys = {
		{ "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
	},
	config = function()
		require("oil").setup({
			watch_for_changes = true,
			delete_to_trash = false,
			default_file_explorer = true,
			columns = {
				"icon",
				"permissions",
				-- "size",
				-- "mtime"
			},
			view_options = {
				show_hidden = true,
			},
		})

		-- vim.g.loaded_netrwPlugin = 1
		-- vim.g.loaded_netrw = 1
	end,
}
