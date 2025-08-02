---
-- @file lua/plugins/nvim-dap.lua
--
-- @brief
-- The configuration file for the plugin nvim-dap
--
-- @author Tanuharja, R.A.
-- @date 2024-10-13
--

return {

	"mfussenegger/nvim-dap",

	lazy = true,

	config = function()
		local dap = require("dap")

		vim.keymap.set("n", "<leader>df", dap.run_to_cursor)

		vim.keymap.set("n", "<leader>dj", dap.continue)
		vim.keymap.set("n", "<leader>dm", dap.step_over)
		vim.keymap.set("n", "<leader>di", dap.step_into)
		vim.keymap.set("n", "<leader>dk", dap.toggle_breakpoint)
		vim.keymap.set("n", "<leader>dn", dap.clear_breakpoints)
		vim.keymap.set("n", "<leader>dl", dap.list_breakpoints)
		vim.keymap.set("n", "<leader>dt", dap.terminate)

		vim.fn.sign_define("DapBreakpoint", {
			text = "--",
			texthl = "DiagnosticError",
			numhl = "",
		})

		vim.fn.sign_define("DapBreakpointRejected", {
			text = "--",
			texthl = "DiagnosticWarn",
			numhl = "",
		})

		vim.fn.sign_define("DapStopped", {
			text = "->",
			texthl = "DiagnosticHint",
			numhl = "",
		})

		-- configure widgets

		local widgets = require("dap.ui.widgets")

		local scopes = widgets.sidebar(widgets.scopes, {}, "vsplit")
		local frames = widgets.sidebar(widgets.frames, { height = 10 }, "belowright split")
		local repl = require("dap.repl")

		vim.keymap.set("n", "<leader>da", function()
			return repl.toggle({}, "belowright split")
		end)

		vim.keymap.set("n", "<leader>ds", scopes.toggle)
		vim.keymap.set("n", "<leader>du", frames.toggle)
		vim.keymap.set("n", "<leader>dh", widgets.hover)
	end,
}
