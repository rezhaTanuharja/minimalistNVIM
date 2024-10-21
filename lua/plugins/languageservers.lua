---
-- @file lua/plugins/languageservers.lua
--
-- @brief
-- The configuration file for the plugin colors
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-10-21
--


return {

  dir = '~/.config/nvim/lua/projects/languageservers.lua',

  event = 'UIEnter',

  config = function()

    require('projects.languageservers').setup {
      lua = true,
      Python = true,
    }

    require('projects.diagnostics').setup {
      virtual_text = false,
      severity_sort = true,
      update_in_insert = false,
    }

  end,

}
