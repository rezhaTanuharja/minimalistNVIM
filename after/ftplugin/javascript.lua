---
-- @file after/ftplugin/javascript.lua
--
-- @brief
-- Javascript - specific config
--
-- @author Tanuharja, R.A.
-- @date 2025-06-21
--

--
-- Sets up development environment for JS, TS, JSX, and TSX.
--
-- + uses a global flag _G.jsx_tsx_env_set to set only once per session.
-- + checks if the language server is installed before enabling.
-- + set adapters and configurations for DAP.
--
_G.jsx_tsx_env_set = _G.jsx_tsx_env_set
	or (function()
		if vim.fn.executable("typescript-language-server") == 1 then
			vim.lsp.enable("typescript-language-server")
		end

		if vim.fn.executable("vscode-eslint-language-server") == 1 then
			vim.lsp.enable("vscode-eslint-language-server")
		end

		local success, debug_js = pcall(require, "debug_js")
		if not success then
			vim.notify("missing module: debug_js")
			return true
		end

		debug_js.setup()

		return true
	end)()

require("snippets").enable_snippets()

local success, textobj = pcall(require, "text_objects")
if not success then
	vim.notify("failed to load a plugin: text_objects")
	return
end

vim.keymap.set("n", "die", function()
	local jsx_element = textobj.get_node("jsx_element")
	textobj.yank_node(jsx_element)
	textobj.delete_node(jsx_element)
end, {
	desc = "delete a jsx element",
	buffer = true,
})

vim.keymap.set("n", "yie", function()
	local jsx_element = textobj.get_node("jsx_element")
	textobj.yank_node(jsx_element)
end, {
	desc = "yank a jsx element",
	buffer = true,
})

vim.keymap.set("n", "gvn", function()
	local variable_declaration = textobj.get_node("variable_declarator")
	local name_fields = textobj.get_field(variable_declaration, "name")

	if not name_fields or #name_fields < 1 then
		return
	end

	textobj.goto_node(name_fields[1])
end, {
	desc = "jump to variable name",
	buffer = true,
})

vim.keymap.set("n", "gto", function()
	local jsx_element = textobj.get_node("jsx_element")
	local opening_tag = textobj.get_field(jsx_element, "open_tag")

	if not opening_tag or #opening_tag < 1 then
		return
	end

	textobj.goto_node(opening_tag[1])
end, {
	desc = "jump to tag opening",
	buffer = true,
})

vim.keymap.set("n", "gtc", function()
	local jsx_element = textobj.get_node("jsx_element")
	local closing_tag = textobj.get_field(jsx_element, "close_tag")

	if not closing_tag or #closing_tag < 1 then
		return
	end

	textobj.goto_node(closing_tag[1])
end, {
	desc = "jump to tag closing",
	buffer = true,
})
