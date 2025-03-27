---
-- @file lua/plugins/bbye.lua
--
-- @brief
-- The configuration file for the plugin bbye
--
-- @author Tanuharja, R.A.
-- @date 2024-08-31
--


return {

  "moll/vim-bbye",

  event = "UIEnter",

  config = function()
    vim.keymap.set("n", "<leader>c", "<cmd>Bdelete!<return>")
    vim.keymap.set("n", "<leader>n", "<cmd>bufdo :Bdelete!<return>")
  end

}
