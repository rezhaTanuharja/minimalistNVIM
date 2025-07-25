---
-- @file lua/plugins/textobjects.lua
--
-- @brief
-- The configuration file for the textobjects plugin
--
-- @author Tanuharja, R.A.
-- @date 2024-04-23
--

local opts = {}

return {

  "textobjects", dev = true,

  event = "UIEnter",
  opts = opts,

}
