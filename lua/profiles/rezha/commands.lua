---
-- @file lua/profiles/rezha/commands.lua
--
-- @brief
-- The configuration file to set custom nvim command
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-08-31
--


-- highlight yanked text
vim.api.nvim_create_autocmd(
  'TextYankPost',
  {
    group = vim.api.nvim_create_augroup(
      'kickstart-highlight-yank', { clear = true }
    ),
    callback = function()
      vim.highlight.on_yank()
    end,
  }
)
