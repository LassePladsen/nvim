return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"lua",
				"vim",
				"vimdoc",
				"query",
				"javascript",
				"html",
				"php",
				"python",
				"typescript",
				"tsx",
				"json",
				"rust",
				"markdown",
				"markdown_inline",
			},
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
			auto_install = true,
		})
	end,
}
