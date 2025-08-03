---
-- @file lua/plugins/vimtex.lua
--
-- @brief
-- The configuration file for the plugin vimtex
--
-- @author Tanuharja, R.A.
-- @date 2025-01-03
--

return {

	"lervag/vimtex",

	init = function()
		vim.g.vimtex_view_method = "zathura"

		vim.g.vimtex_compiler_silent = 1
		vim.g.vimtex_compiler_method = "latexmk"
		vim.g.vimtex_compiler_latexmk = {
			out_dir = "build",
			options = { "-pdf", "-interaction=nonstopmode", "-synctex=1" },
		}

		vim.g.vimtex_doc_enabled = 0
		vim.g.vimtex_complete_enabled = 0
		vim.g.vimtex_syntax_enabled = 0
		vim.g.vimtex_imaps_enabled = 0

		vim.g.vimtex_view_forward_search_on_start = 0
	end,
}
