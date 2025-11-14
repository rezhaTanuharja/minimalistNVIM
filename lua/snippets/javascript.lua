---
-- @file lua/snippets/javascript.lua
--
-- @brief
-- Snippets for Javascript files
--
-- @author Tanuharja, R.A.
-- @date 2024-09-25
--

local snippets = {

  func = {
    "(${1:}) => {$0}",
  },

  tag = {
    "<${1:tag}$2>$0</$1>",
  },

  component = {
    "<${1:Component}/>",
  },

}

for keyword, body in pairs(snippets) do
  snippets[keyword] = table.concat(body, "\n")
end

return snippets
