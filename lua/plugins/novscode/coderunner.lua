return {
	"CRAG666/code_runner.nvim",
	dependencies = {
		"akinsho/toggleterm.nvim",
	},
	config = function()
		vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#ffffff" })
		require("code_runner").setup({
			filetype = {
				java = {
					"cd $dir &&",
					"javac $fileName &&",
					"java $fileNameWithoutExt &&",
					"rm $fileNameWithoutExt",
				},
				python = "python3 -i",
				typescript = "node",
				rust = {

					"cd $dir &&",
					"rustc $fileName &&",
					"$dir/$fileNameWithoutExt &&",
					"rm $dir/$fileNameWithoutExt",
				},
				c = "cd $dir && gcc $fileName -o /tmp/$fileNameWithoutExt && /tmp/$fileNameWithoutExt",
				php = "php",
			},
			float = {
				border = "rounded",
				border_hl = "FloatBorder",
			},
		})
	end,
	keys = {
		{ "<leader>rt", ":RunFile toggleterm<CR>", desc = "[r]un file in [t]erminal (toggleterm.nvim)" },
		{ "<leader>rf", ":RunFile float<CR>", desc = "[r]un file in [f]loat" },
		{ "<leader>x", ":RunFile float<CR>", desc = "e[x]ecute file with code_runner in float window" },
	},
}
