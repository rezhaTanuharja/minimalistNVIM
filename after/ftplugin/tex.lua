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

		local server = vim.v.servername
		local zathura_command = {
			"zathura",
			"-x",
			string.format('nvim --server "%s" --remote-silent %%{input}', server),
		}

		vim.api.nvim_create_user_command("Zathura", function(opts)
			vim.fn.jobstart(vim.fn.extend(vim.deepcopy(zathura_command), { opts.args }), { detach = false })
		end, { desc = "Open Zathura", nargs = 1 })

		return true
	end)()

vim.opt_local.makeprg = "latexmk -pdf -synctex=1 -interaction=nonstopmode -outdir=build"

require("snippets").enable_snippets()

local success, textobj = pcall(require, "text_objects")
if not success then
	vim.notify("failed to load a plugin: text_objects")
	return
end

vim.keymap.set("n", "gst", function()
	local section = textobj.get_node("section")

	if not section then
		return
	end

	textobj.goto_node(section)
end, {
	desc = "jump to top of the current section",
	buffer = true,
})

vim.keymap.set("n", "gss", function()
	local subsection = textobj.get_node("subsection")

	if not subsection then
		return
	end

	textobj.goto_node(subsection)
end, {
	desc = "jump to top of the current subsection",
	buffer = true,
})
