---
-- @file lua/profiles/rezha/plugins/bufferline.lua
--
-- @brief
-- The configuration file for the plugin bufferline
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-08-31
--


return {

  'moll/vim-bbye',

  event = {'BufReadPost', 'BufNewFile'},

  config = function()
    vim.keymap.set('n', '<leader>c', ':Bdelete!<CR>', { noremap = true, silent = true } )
  end

}
