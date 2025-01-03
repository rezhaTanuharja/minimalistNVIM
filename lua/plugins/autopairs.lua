---
-- @file lua/plugins/autopairs.lua
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

  opts = {

    check_ts = true,

    ts_config = {
      lua = { 'string' },
      python = { 'string' },
    },

    disable_filetype = { 'TelescopePrompt', 'spectre_panel' },

    fast_wrap = {
      map = '<C-k>',
      chars = { '{', '[', '(', '"', "'" },
      pattern = [=[[%'%"%>%]%)%}%,]]=],
      offset = 0,
      end_key = 'k',
      keys = 'qwertyuiopzxcvbnmasdfghjkl',
      check_comma = true,
      highlight = 'PmenuSel',
      highlight_grey = 'LineNr',
    },

  },

}
