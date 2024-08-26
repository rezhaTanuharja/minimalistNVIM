---
-- @file lua/rezha/pluginConfig/luasnip/snippets/python.lua
--
-- @brief
-- Defines snippets for Python
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-08-26
--

local success, luasnip = pcall(require, "luasnip")
if not success then
  vim.notify("Error loading plugin: luasnip")
  return
end

local t = luasnip.text_node
local i = luasnip.insert_node

luasnip.add_snippets(

  "python", {

    -- A snippet to define a new function
    luasnip.snippet("def", {
      t("def "), i(1, "function_name"), t("("), i(2), t({"):", "\t"}),
      i(0, "pass"),
    }),

    -- A snippet to define a parent class
    luasnip.snippet("class", {
      t("class "), i(1, "ClassName"), t({":", ""}),
      t({"", "\t"}),
      t("def __init__(self"), i(2), t({"):", "\t\t"}),
      i(0, "pass"),
    }),

    -- A snippet to define a child class
    luasnip.snippet("class", {
      t("class "), i(1, "ClassName"), t("("), i(2, "ABC"), t({"):", ""}),
      t({"", "\t"}),
      t("def __init__(self"), i(3), t({"):", "\t\t"}),
      i(0, "pass"),
    }),

    -- A snippet to define an abstract method
    luasnip.snippet("def", {
      t({"@abstractmethod", ""}),
      t("def "), i(1, "function_name"), t("("), i(2, "*args, **kwargs"), t({"):", "\t"}),
      i(0, "pass"),
    }),

  }

)

