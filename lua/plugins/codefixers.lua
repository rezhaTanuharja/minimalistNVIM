---
-- @file lua/plugins/codefixers.lua
--
-- @brief
-- The file to set option for formatters and linters
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-12-01
--


local opts = {}


opts.language_config = {

  python = {
    executable = 'ruff',
    pattern = '*.py',
    actions = {
      'silent! !ruff check --fix %',
      'silent! !ruff format %',
    },
  },

}


return {

  dir = vim.fn.stdpath('config') .. '/projects/codefixers.lua',

  event = 'UIEnter',

  config = function()

    local success, formatters = pcall(require, 'codefixers')
    if not success then
      vim.notify('Failed to load plugin: formatters')
      return
    end

    formatters.setup(opts)

  end

}
