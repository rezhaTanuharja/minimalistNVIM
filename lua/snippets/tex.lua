---
-- @file lua/snippets/tex.lua
--
-- @brief
-- Snippets for Tex files
--
-- @author Tanuharja, R.A.
-- @date 2024-08-09
--

local snippets = {

	skeleton = {
		"\\documentclass{${1:class}}",
		"",
		"${2:%preamble}",
		"",
		"\\begin{document}",
		"",
		"$0",
		"",
		"\\end{document}",
	},

	environment = {
		"\\begin{${1:env}}",
		"\t$0",
		"\\end{$1}",
	},

	equation = {
		"\\begin{equation*}",
		"\t$0",
		"\\end{equation*}",
	},

	equation_with_label = {
		"\\begin{equation}",
    "\\label{eq:${1:label}}",
		"\t$0",
		"\\end{equation}",
	},
}

for keyword, body in pairs(snippets) do
	snippets[keyword] = table.concat(body, "\n")
end

return snippets
