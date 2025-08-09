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

}

for keyword, body in pairs(snippets) do
  snippets[keyword] = table.concat(body, "\n")
end

return snippets
