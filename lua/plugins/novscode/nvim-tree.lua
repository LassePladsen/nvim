return {
	"nvim-tree/nvim-tree.lua",
	enabled = false,
	config = function()
		-- disable netrw at the very start of your init.lua
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- optionally enable 24-bit colour
		vim.opt.termguicolors = true

		require("nvim-tree").setup({
			actions = {
				open_file = {
					quit_on_open = true,
				}
			},
			sort = {
				sorter = "case_sensitive",
			},
			view = {
				width = 20,
				side = "right",
				adaptive_size = true,
			},
			renderer = {
				group_empty = true,
			},
			filters = {
				dotfiles = true,
				git_ignored = false,
			},
		})

		vim.keymap.set("n", "<leader>tt", "<cmd>NvimTreeToggle<CR>", { desc = "[t]ree [t]oggle" })
		vim.keymap.set("n", "<leader>se", "<cmd>NvimTreeToggle<CR>", { desc = "[s]earch [e]xplorer" })
		vim.keymap.set("n", "<leader>tf", "<cmd>NvimTreeFocus<CR>", { desc = "[t]ree [f]ocus" })
		vim.keymap.set("n", "<leader>tF", "<cmd>NvimTreeFindFile<CR>", { desc = "[t]ree [F]ind file" })
		vim.keymap.set("n", "<leader>tc", "<cmd>NvimTreeCollapse<CR>", { desc = "[t]ree [c]ollapse" })
	end,
}
