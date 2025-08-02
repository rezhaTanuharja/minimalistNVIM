---
-- @file after/plugin/diagnostics.lua
--
-- @brief
-- Configure the behaviour of diagnostics
--
-- @author Tanuharja, R.A.
-- @date 2024-12-20
--

vim.diagnostic.config({

	underline = false,
	virtual_text = false,
	virtual_lines = false,
	severity_sort = true,
	update_in_insert = false,

	signs = {

		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.HINT] = "",
			[vim.diagnostic.severity.INFO] = "",
		},

		linehl = {
			[vim.diagnostic.severity.ERROR] = "ErrorMsg",
			[vim.diagnostic.severity.WARN] = "None",
			[vim.diagnostic.severity.HINT] = "None",
			[vim.diagnostic.severity.INFO] = "None",
		},

		numhl = {
			[vim.diagnostic.severity.ERROR] = "ErrorMsg",
			[vim.diagnostic.severity.WARN] = "WarningMsg",
			[vim.diagnostic.severity.HINT] = "DiagnosticHint",
			[vim.diagnostic.severity.INFO] = "DiagnosticHint",
		},
	},

	float = {
		title = " Diagnostic ",
		header = "",
		border = "single",
		scope = "line",
	},
})

vim.opt["signcolumn"] = "yes"

vim.keymap.set("n", "gl", vim.diagnostic.open_float)
vim.keymap.set("n", "gq", vim.diagnostic.setqflist)

vim.keymap.set("n", "gK", function()
	if not vim.diagnostic.config().virtual_lines then
		vim.diagnostic.config({ virtual_lines = { current_line = true } })
	else
		vim.diagnostic.config({ virtual_lines = false })
	end
end, { desc = "Toggle diagnostic current line virtual_lines" })

vim.keymap.set("n", "gh", function()
	local line = vim.api.nvim_win_get_cursor(0)[1]
	local diagnostics = vim.diagnostic.get(0, { lnum = line - 1 })

	vim.fn.setreg("+", {}, "V")

	for _, diagnostic in ipairs(diagnostics) do
		vim.fn.setreg("+", vim.fn.getreg("+") .. diagnostic["message"], "V")
	end
end)
