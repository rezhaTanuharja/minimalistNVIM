---
-- @file lua/plugins/developers/codefixers.lua
--
-- @brief
-- The configuration file for the plugin developers: codefixers
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-12-20
--


return {

  {
    executable = 'ruff',
    pattern = '*.py',
    actions = {
      'silent! !ruff check --extend-select I --fix %',
      'silent! !ruff format %',
    },
  },

}
