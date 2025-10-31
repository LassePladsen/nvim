return {
	"nosduco/remote-sshfs.nvim",
	enabled = false,
	dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	opts = {
		ui = {
			confirm = {
				connect = false,
			},
		},
	},
}
