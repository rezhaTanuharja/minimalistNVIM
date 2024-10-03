---
-- @file lua/commands.lua
--
-- @brief
-- The configuration file to set custom nvim command
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-08-31
--


-- autocommand group intended for visual aids
vim.api.nvim_create_augroup('visual_aid', { clear = true })


-- highlight yanked text
vim.api.nvim_create_autocmd(
  'TextYankPost', {
    group = visual_aid,
    callback = function()
      vim.highlight.on_yank()
    end,
  }
)


-- activate cursorline when entering a window
vim.api.nvim_create_autocmd(
  {'BufEnter', 'WinEnter'}, {
    group = visual_aid,
    callback = function()
      vim.cmd('setlocal cursorline')
    end,
  }
)

-- deactivate cursorline when leaving a window
vim.api.nvim_create_autocmd(
  {'BufLeave', 'WinLeave'}, {
    group = visual_aid,
    callback = function()
      vim.cmd('setlocal nocursorline')
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

-- when in visual mode, type this command to perform multiple inputs after certain word
vim.api.nvim_create_user_command(
  'AppendTo',
  function(opts)
    local start_line = vim.fn.line("'<")
    local end_line = vim.fn.line("'>")
    local word = opts.args
    vim.fn.cursor(start_line, 1)
    vim.cmd('normal! V')
    vim.fn.cursor(end_line, 1)
    vim.api.nvim_feedkeys(":s/\\(" .. word .. "\\)/\\1", 'c', false)
  end,
  { nargs = 1, range = true }
)
