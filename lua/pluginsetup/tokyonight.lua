---
-- @file lua/profiles/rezha/plugins/tokyonight.lua
--
-- @brief
-- The configuration file for the plugin tokyonight
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-08-31
--


return {

  -- github repository for tokyonight
  "folke/tokyonight.nvim",

  -- ensure this is loaded during startup
  lazy = false,

  -- load colorscheme before other plugins
  priority = 1000,

  init = function()

    -- use protected call to attempt to load colorscheme
    local success, _ = pcall(vim.cmd, "colorscheme tokyonight")
    if not success then
      vim.notify("Failed to load colorscheme: tokyonight")
      return
    end

  end,

  config = function()

    -- use protected call to attempt to load plugin
    local success, tokyonight = pcall(require, 'tokyonight')
    if not success then
      vim.notify('Failed to load plugin: tokyonight')
      return
    end

    tokyonight.setup {

      -- available styles are 'day', 'night', 'storm', 'moon'
      style = 'night',

      -- looks cooler
      transparent = true,

      -- for further customization
      styles = {
        sidebars = 'transparent',
        floats = 'transparent',
      },

      -- change the yellow color because it is ugly
      on_colors = function(colors)
        colors.yellow = "#F3DFCB"
      end

    }

  end,

}
