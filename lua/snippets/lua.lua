---
-- @file lua/snippets/lua.lua
--
-- @brief
-- Snippets for Lua files
--
-- @author Tanuharja, R.A.
-- @date 2024-08-12
--

local snippets = {

  named_table = {
    "${1:name} = {",
    "\t$0",
    "}",
  },

  protected_require = {
    'local ${1:success}, ${2:variable} = pcall(require, "${3:module}")',
    "if not ${1} then",
    '\tvim.notify("failed to load a module: $3")',
    "\treturn",
    "end",
  },
}

for keyword, body in pairs(snippets) do
  snippets[keyword] = table.concat(body, "\n")
end

return snippets
