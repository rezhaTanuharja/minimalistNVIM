---
-- @file lua/plugins/developers/tests.lua
--
-- @brief
-- The configuration file for the plugin developers: tests
--
-- @author Tanuharja, R.A.
-- @date 2024-12-20
--


return {

  {
    executable = "pytest",
    pattern = "python",
    makeprg = 'pytest \\| tee log \\| grep "Error$"',
    errorformat = "%f:%l: %m",
  },

}
