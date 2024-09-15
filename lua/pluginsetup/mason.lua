---
-- @file lua/profiles/rezha/plugins/mason.lua
--
-- @brief
-- The configuration file for the plugin mason
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-08-31
--


return {

  'williamboman/mason.nvim',

  config = function ()

    local success, mason = pcall(require, 'mason')
    if not success then
      vim.notify('Failed to load plugin: mason')
      return
    end

    mason.setup {

      ui = {
        border = 'none',
        icons = {
          package_installed = 'i',
          package_pending = 'p',
          package_uninstalled = 'u',
        },
      },

      log_level = vim.log.levels.ERROR,
      max_concurrent_installers = 4,

    }

  end,
}
