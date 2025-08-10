---
-- @file lua/plugins/blankline.lua
--
-- @brief
-- The configuration file for the plugin blankline
--
-- @author Tanuharja, R.A.
-- @date 2024-08-31
--

local opts = {
	indent = { char = "│" },
	exclude = {
		filetypes = { "tex", "plaintex", "bib" },
	},

	scope = {
		enabled = true,
		show_start = false,
		show_end = false,
		highlight = { "Special" },
		priority = 500,
	},
}

return {

	"lukas-reineke/indent-blankline.nvim",

	config = function()
		local success, blankline = pcall(require, "ibl")
		if not success then
			vim.notify("Failed to load a plugin: blankline")
			return
		end

		blankline.setup(opts)
	end,
}
