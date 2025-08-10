---
-- @file after/ftplugin/tex.lua
--
-- @brief
-- LaTeX - specific config
--
-- @author Tanuharja, R.A.
-- @date 2025-06-24
--

--
-- Sets up development environment for Tex.
--
-- + uses a global flag _G.tex_env_set to set only once per session.
-- + checks if the language server is installed before enabling.
--
_G.tex_env_set = _G.tex_env_set
	or (function()
		if vim.fn.executable("texlab") then
			vim.lsp.enable("texlab")
		end

		return true
	end)()

vim.o.messagesopt = "wait:1000,history:100"

require("snippets").enable_snippets()
