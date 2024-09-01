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

-- when in visual mode, type this command to replace words
vim.api.nvim_create_user_command(
  'ExactReplace',
  function(opts)
      local start_line = vim.fn.line("'<")
      local end_line = vim.fn.line("'>")
      local word = opts.args
      vim.fn.cursor(start_line, 1)
      vim.cmd('normal! V')
      vim.fn.cursor(end_line, 1)
      vim.api.nvim_feedkeys(":s/\\<" .. word .. "\\>/", 'c', false)
  end,
  { nargs = 1, range = true }
)
