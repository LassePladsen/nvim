-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.lazy")

-- hightlight on yank
vim.cmd([[au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=250, on_visual=true}]])

-- listchars not supported in regular vim
-- vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.g.have_nerd_font = true

-- function that prints objects nicely. NB: use := instead!
function _G.put(...)
	local objects = {}
	for i = 1, select("#", ...) do
		local v = select(i, ...)
		table.insert(objects, vim.inspect(v))
	end
	print(table.concat(objects, "\n"))
	return ...
end

-- CUSTOM COMMANDS
vim.api.nvim_create_user_command("DisableVirtualText", function()
	vim.diagnostic.config({ virtual_text = false })
end, { nargs = 0 })
