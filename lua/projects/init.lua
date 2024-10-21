---
-- @file lua/projects/init.lua
--
-- @brief
-- The starting point of the project config
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-10-21
--


return {

    dir = '~/.config/nvim/lua/projects',

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

      require('projects.colors').setup {
        flavour = 'grayscale',
      }

      require('projects.statusline').setup {
        single_cursorline = true,
        flavour = 'grayscale',
      }

    end,

  }
