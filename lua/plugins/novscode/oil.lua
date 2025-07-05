return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
	lazy = false,
	opts = {
		watch_for_changes = true,
		delete_to_trash = false,
		default_file_explorer = true, -- only works with lazy = false
		columns = {
			"icon",
			"permissions",
			-- "size",
			-- "mtime"
		},
		view_options = {
			show_hidden = true,
		},
	},
	keys = {
		{ "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
	},
}
