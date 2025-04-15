return {
	"stevearc/oil.nvim",
	opts = {
		watch_for_changes = true,
		delete_to_trash = false,
		default_file_explorer = true,
		columns = {
			"icon",
			-- "permissions",
			-- "size",
			-- "mtime"
		},
		view_options = {
			show_hidden = true,
		},
	},
	keys = {
		{"-", "<CMD>Oil<CR>", desc = "Open parent directory"},
	},
}
