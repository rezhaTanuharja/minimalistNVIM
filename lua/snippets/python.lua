---
-- @file lua/snippets/python.lua
--
-- @brief
-- Snippets for Python files
--
-- @author Tanuharja, R.A.
-- @date 2024-08-09
--

local snippets = {

	class = {
		"class ${1:class_name}:",
		"\tdef __init__(self, *args, **kwargs):",
		"\t\tpass",
	},

	class_abstract = {
		"class ${1:class_name}(${2:parent_name}):",
		"\t@abstractmethod",
		"\tdef __init__(self, *args, **kwargs):",
		"\t\tpass",
	},

  debug_entry_point = {
    "if not debugpy.is_client_connected():",
    "\tdebugpy.listen((\"${1:0.0.0.0}\", ${2:1234}))",
    "\tdebugpy.wait_for_client()",
    "\tdebugpy.breakpoint()",
  },

  break_point = {
    "debugpy.breakpoint()",
  },
}

for keyword, body in pairs(snippets) do
	snippets[keyword] = table.concat(body, "\n")
end

return snippets
