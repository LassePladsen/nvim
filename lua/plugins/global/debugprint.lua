return {
	"andrewferrier/debugprint.nvim",

	dependencies = {
		"echasnovski/mini.nvim", -- Optional: Needed for line highlighting (full mini.nvim plugin)
		-- ... or ...
		"echasnovski/mini.hipatterns", -- Optional: Needed for line highlighting ('fine-grained' hipatterns plugin)

		"ibhagwan/fzf-lua", -- Optional: If you want to use the `:Debugprint search` command with fzf-lua
		"nvim-telescope/telescope.nvim", -- Optional: If you want to use the `:Debugprint search` command with telescope.nvim
		"folke/snacks.nvim", -- Optional: If you want to use the `:Debugprint search` command with snacks.nvim
	},

	opts = {
		keymaps = {
			normal = {
				toggle_comment_debug_prints = "g?c",
				delete_debug_prints = "g?d",
				search_debug_prints = "g?l",
			},
			insert = {
				variable = "<C-G>v",
			},
			visual = {
				variable_below = "g?v",
				variable_above = "g?V",
			},
		},
		-- … Other options
	},

	lazy = false, -- Required to make line highlighting work before debugprint is first used
	version = "*", -- Remove if you DON'T want to use the stable version
}
