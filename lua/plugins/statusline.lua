---
-- @file lua/plugins/statusline.lua
--
-- @brief
-- The configuration file for the plugin colors
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-10-21
--


return {

  dir = '~/.config/nvim/lua/projects/statusline.lua',

  event = 'UIEnter',

  config = function()

    require('projects.statusline').setup {

      single_cursorline = true,
      flavour = 'grayscale',

    }

  end,

}
