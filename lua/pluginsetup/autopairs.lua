---
-- @file lua/profiles/rezha/plugins/autopairs.lua
--
-- @brief
-- The configuration file for the plugin autopairs
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-08-31
--


return {

  'windwp/nvim-autopairs',

  event = 'InsertEnter',

  config = function()

    local success, autopairs = pcall(require, 'nvim-autopairs')
    if not success then
      vim.notify('Failed to load plugin: autopairs')
      return
    end

    autopairs.setup {

      check_ts = true,
      
      ts_config = {
        lua = {'string', 'source'},
      },

      disable_filetype = {'TelescopePrompt', 'spectre_panel'},

      fast_wrap = {
        map = '<M-e>',
        chars = {'{', '[', '(', '"', "'"},
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),
        -- pattern = [=[[%'%"%>%]%)%}%, ]]=],
        offset = 0,
        end_key = '$',
        keys = 'qwertyuiopzxcvbnmasdfghjkl',
        check_comma = true,
        highlight = 'PmenuSel',
        highlight_grey = 'LineNr',
      },

    }

  end,

}
