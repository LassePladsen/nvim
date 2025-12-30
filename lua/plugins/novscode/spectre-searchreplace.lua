return {
	"nvim-pack/nvim-spectre",
	config = function()
		vim.keymap.set("n", "<leader>Ss", '<cmd>lua require("spectre").toggle()<CR>', {
			desc = "Spectre toggle",
		})
		vim.keymap.set("n", "<leader>Sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
			desc = "Spectre Search current word",
		})
		vim.keymap.set("v", "<leader>Sw", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
			desc = "Spectre Search current word",
		})
		vim.keymap.set("n", "<leader>Sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
			desc = "Spectre Search on current file",
		})
	end,
}
