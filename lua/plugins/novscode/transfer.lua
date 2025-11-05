return {
	"coffebar/transfer.nvim",
	lazy = true,
	cmd = { "TransferInit", "DiffRemote", "TransferUpload", "TransferDownload", "TransferDirDiff", "TransferRepeat" },
	opts = {},
	keys = {
		{ "<leader>ti", "<cmd>TransferInit<cr>", desc = "Remote [T]ransfer [i]nit" },
		{ "<leader>tu", "<cmd>TransferUpload<cr>", desc = "Remote [T]ransfer [u]pload" },
		{ "<leader>td", "<cmd>TransferDownload<cr>", desc = "Remote [T]ransfer [d]ownload" },
		{ "<leader>tD", "<cmd>TransferDirDiff .<cr>", desc = "Remote [T]ransfer [D]ir diff" },
		{ "<leader>ta", "<cmd>TransferUpload .<cr>", desc = "Remote [T]ransfer upload [a]ll" },
		{ "<leader>tA", "<cmd>TransferDownload .<cr>", desc = "Remote [T]ransfer download [A]ll" },
	},
}
