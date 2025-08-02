---
-- @file lsp/typescript-language-server.lua
--
-- @brief
-- The configuration file for the tsls LSP
--
-- @author Tanuharja, R.A.
-- @date 2025-07-18
--

return {

	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},

	cmd = { "typescript-language-server", "--stdio" },

	root_markers = { ".git", "package.json" },

	init_options = {
		hostInfo = "neovim",
	},

	settings = {},
}
