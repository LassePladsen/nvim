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

-- use diagnostics open_float instead of virtual_lines https://oneofone.dev/post/neovim-diagnostics-float/
-- DID NOT WORK!
-- local group = vim.api.nvim_create_augroup("OoO", {})

-- local function au(typ, pattern, cmdOrFn)
-- 	if type(cmdOrFn) == "function" then
-- 		vim.api.nvim_create_autocmd(typ, { pattern = pattern, callback = cmdOrFn, group = group })
-- 	else
-- 		vim.api.nvim_create_autocmd(typ, { pattern = pattern, command = cmdOrFn, group = group })
-- 	end
-- end

-- au({ "CursorHold", "InsertLeave" }, nil, function()
-- 	local opts = {
-- 		focusable = false,
-- 		scope = "cursor",
-- 		close_events = { "BufLeave", "CursorMoved", "InsertEnter" },
-- 	}
-- 	vim.diagnostic.open_float(nil, opts)
-- end)

-- au("InsertEnter", nil, function()
-- 	vim.diagnostic.enable(false)
-- end)

-- au("InsertLeave", nil, function()
-- 	vim.diagnostic.enable(true)
-- end)

-- CUSTOM COMMANDS
vim.api.nvim_create_user_command("DisableVirtualText", function()
	vim.diagnostic.config({ virtual_text = false })
end, { nargs = 0 })
