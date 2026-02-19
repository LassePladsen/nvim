return {
	"coffebar/transfer.nvim",
	lazy = true,
	cmd = { "TransferInit", "DiffRemote", "TransferUpload", "TransferDownload", "TransferDirDiff", "TransferRepeat" },
	opts = {},
	keys = {
		{ "<leader>ti", "<cmd>TransferInit<cr>", desc = "Remote [T]ransfer [i]nit" },
		{ "<leader>tu", "<cmd>TransferUpload<cr>", desc = "Remote [T]ransfer [u]pload" },
		{ "<leader>td", "<cmd>TransferDownload<cr>", desc = "Remote [T]ransfer [d]ownload" },
		{ "<leader>tf", "<cmd>TransferDirDiff .<cr>", desc = "Remote [T]ransfer dir diff" },
		{ "<leader>tU", "<cmd>TransferUpload .<cr>", desc = "Remote [T]ransfer [U]pload all" },
		{ "<leader>tD", "<cmd>TransferDownload .<cr>", desc = "Remote [T]ransfer [D]ownload all" },
	},
}
