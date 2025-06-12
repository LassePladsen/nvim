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

-- CUSTOM MACROS. Could use plugin debugprint instead
-- local esc = vim.api.nvim_replace_termcodes("<ESC>", true, true, true)
-- -- debug printing variable in visual selection for different filetypes
-- -- js and ts
-- vim.api.nvim_create_augroup("JSLogMacro", { clear = true })
-- vim.api.nvim_create_autocmd("FileType", {
-- 	group = "JSLogMacro",
-- 	pattern = { "javascirpt", "typescript" },
-- 	callback = function()
-- 		vim.fn.setreg("l", "yoconsole.log('" .. esc .. "pa: ', " .. esc .. "pA);" .. esc)
-- 	end,
-- })

-- -- php
-- vim.api.nvim_create_augroup("PHPLogMacro", { clear = true })
-- vim.api.nvim_create_autocmd("FileType", {
-- 	group = "PHPLogMacro",
-- 	pattern = { "php" },
-- 	callback = function()
-- 		vim.fn.setreg("l", "yoerror_log('" .. esc .. "pa: '" .. esc .. " . print_r(" .. esc .. "pa, true));" .. esc)
-- 	end,
-- })

-- CUSTOM COMMANDS
vim.api.nvim_create_user_command("DisableVirtualText", function()
	vim.diagnostic.config({ virtual_text = false })
end, { nargs = 0 })
