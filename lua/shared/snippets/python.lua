---
-- @file lua/shared/snippets/python.lua
--
-- @brief
-- The definition file for python snippets
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-08-31
--


return {

  -- a snippet for a new function
  s("def", {
    t("def "), i(1, "function_name"), t("("), i(2), t({"):", "\t"}),
    i(0, "pass"),
  }),

  -- a snippet for a new parent class
  s("class", {
    t("class "), i(1, "ClassName"), t({":", ""}),
    t({"", "\t"}),
    t("def __init__(self"), i(2), t({"):", "\t\t"}),
    i(0, "pass"),
  }),

  -- A snippet to define a child class
  s("class", {
    t("class "), i(1, "ClassName"), t("("), i(2, "ABC"), t({"):", ""}),
    t({"", "\t"}),
    t("def __init__(self"), i(3), t({"):", "\t\t"}),
    i(0, "pass"),
  }),

  -- A snippet to define an abstract method
  s("def", {
    t({"@abstractmethod", ""}),
    t("def "), i(1, "function_name"), t("("), i(2, "*args, **kwargs"), t({"):", "\t"}),
    i(0, "pass"),
  }),

}
