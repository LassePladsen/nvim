return {
	"sylvanfranklin/omni-preview.nvim",
	dependencies = {
		-- CSV
		{ "hat0uma/csvview.nvim", lazy = true },
		-- markdown
		{ "toppair/peek.nvim", lazy = true, build = "deno task --quiet build:fast" },
	},
	config = function()
		require("omni-preview").setup({})
		require("csvview").setup({
			view = {
				header_lnum = 0,
				sticky_header = { enabled = true },
				display_mode = "border",
			},
			keymaps = {
				-- Text objects for selecting fields
				textobject_field_inner = { "if", mode = { "o", "x" } },
				textobject_field_outer = { "af", mode = { "o", "x" } },
				-- Excel-like navigation:
				-- Use <Tab> and <S-Tab> to move horizontally between fields.
				-- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
				-- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
				jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
				jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
				jump_next_row = { "<Enter>", mode = { "n", "v" } },
				jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
			},
		})
		require("peek").setup()
		vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
		vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})

		vim.keymap.set("n", "<leader>P", ":OmniPreview toggle<CR>", { silent = true })
	end,
}
