return {
	"ray-x/lsp_signature.nvim",
	event = "InsertEnter",
	config = function()
		require("lsp_signature").setup({
			border = "rounded",
			-- floating_window_above_cur_line = false,
			toggle_key = "<C-k>",
			-- transparency = 90,
			-- move_signature_window_key = { "<M-k>", "<M-j>", "<M-h>", "<M-l>" },
		})
	end,
}
