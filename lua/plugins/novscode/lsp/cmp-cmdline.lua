return { -- Completion for cmdline and / search
	"hrsh7th/cmp-cmdline",
	dependencies = {
		"hrsh7th/nvim-cmp",
	},
	config = function()
		local cmp = require("cmp")
		local keymap_override = {
			["<Tab>"] = {
				c = function()
					cmp.confirm()
				end,
			},
		}
		-- `/` cmdline setup.
		cmp.setup.cmdline("/", {
			mapping = cmp.mapping.preset.cmdline(keymap_override),
			sources = {
				{ name = "buffer" },
			},
		})

		-- `:` cmdline setup.
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(keymap_override),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{
					name = "cmdline",
					option = {
						ignore_cmds = { "Man", "!" },
					},
				},
			}),
		})
	end,
}
