---
-- @file lua/plugins/prompt.lua
--
-- @brief
-- The configuration file for the plugin prompt
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-12-07
--


return {

  'prompt', dev = true,

  event = 'UIEnter',

  opts = {

    shopt = {
      'globstar',
    },

    keymaps = {

      start_shell = '<leader>pp',
      goto_file = 'gf',

    },

  },

}
