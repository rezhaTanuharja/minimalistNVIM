---
-- @file lua/plugins/gitsigns.lua
--
-- @brief
-- The configuration file for the plugin gitsigns
--
-- @author Tanuharja, R.A.
-- @date 2024-08-31
--

local opts = {
	signs = {
		add = { text = "│" },
		change = { text = "│" },
		delete = { text = "│" },
		topdelete = { text = "│" },
		changedelete = { text = "│" },
	},

	signcolumn = true,
	numhl = false,
	linehl = false,
	word_diff = false,

	attach_to_untracked = false,
	current_line_blame = false,

	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol",
		delay = 1000,
		ignore_whitespace = true,
	},

	sign_priority = 6,
	update_debounce = 200,
	status_formatter = nil,
	max_file_length = 8000,

	preview_config = {
		border = "single",
		style = "minimal",
		relative = "cursor",
		row = 0,
		col = 1,
	},
}

return {

	"lewis6991/gitsigns.nvim",

	config = function()
		local success, gitsigns = pcall(require, "gitsigns")
		if not success then
			vim.notify("Error loading plugin: gitsigns")
			return
		end

		gitsigns.setup(opts)

		vim.keymap.set("n", "<leader>k", gitsigns.preview_hunk)
		vim.keymap.set("n", "<leader>u", gitsigns.reset_hunk)
		vim.keymap.set("n", "<leader>xx", gitsigns.diffthis)
		vim.keymap.set("n", "<leader>xc", function()
			gitsigns.diffthis("main")
		end)
		vim.keymap.set("n", "<leader>z", "<cmd>wincmd p | q<return>")

		vim.keymap.set("n", "<C-g>", gitsigns.stage_hunk)
		vim.keymap.set("n", "<C-f>", gitsigns.stage_buffer)
		vim.keymap.set("n", "B", gitsigns.blame_line)
		vim.keymap.set("n", "<C-a>", gitsigns.blame)

		vim.keymap.set("n", "gnh", function()
			gitsigns.nav_hunk("next")
		end)
		vim.keymap.set("n", "gph", function()
			gitsigns.nav_hunk("prev")
		end)

		vim.keymap.set("n", "qf", function()
			gitsigns.setqflist("all")
		end)

		vim.api.nvim_set_hl(0, "GitSignsAddInline", { fg = "NvimLightYellow", bg = "None" })
		vim.api.nvim_set_hl(0, "GitSignsDeleteInline", { fg = "NvimLightYellow", bg = "None" })
		vim.api.nvim_set_hl(0, "GitSignsStagedAdd", { fg = "#AAAAAA" })
		vim.api.nvim_set_hl(0, "GitSignsStagedChange", { fg = "#AAAAAA" })
		vim.api.nvim_set_hl(0, "GitSignsStagedChangeDelete", { fg = "#AAAAAA" })

		vim.api.nvim_set_hl(0, "GitSignsAddPreview", { link = "Statement" })
	end,
}
