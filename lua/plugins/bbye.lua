---
-- @file lua/plugins/bbye.lua
--
-- @brief
-- The configuration file for the plugin bbye
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-08-31
--


return {

  'moll/vim-bbye',

  event = {'BufReadPost', 'BufNewFile'},

  config = function()
    vim.keymap.set('n', '<leader>c', ':Bdelete!<CR>')
  end

}
