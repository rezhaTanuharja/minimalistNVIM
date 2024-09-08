---
-- @file lua/shared/snippets/neorg.lua
--
-- @brief
-- The definition file for neorg snippets
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-09-08
--


return {

  -- a snippet for a code block
  s("code", {
    t("@code "), i(1, "language"), t({"", ""}),
    i(2, "code"), t({"", ""}),
    t("@end"),
  }),

}
