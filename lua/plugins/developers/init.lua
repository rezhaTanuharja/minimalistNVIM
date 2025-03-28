---
-- @file lua/plugins/developers/init.lua
--
-- @brief
-- The configuration file for the plugin developers
--
-- @author Tanuharja, R.A.
-- @date 2024-12-07
--


local opts = {}

opts.servers    = require("plugins.developers.languageservers")
opts.tests      = require("plugins.developers.tests")
opts.codefixers = require("plugins.developers.codefixers")

opts.keymaps = {
  refresh     = "gn",
}

return {

  "developers", dev = true,

  event = "UIEnter",
  opts = opts,

}
