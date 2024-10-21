---
-- @file lua/plugins/colors.lua
--
-- @brief
-- The configuration file for the plugin colors
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-10-21
--


return {

  dir = '~/.config/nvim/lua/projects/colors.lua',

  event = 'UIEnter',

  config = function()
    require('projects.colors').setup {
      flavour = 'grayscale',
    }
  end,

}
