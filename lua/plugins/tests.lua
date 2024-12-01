---
-- @file lua/plugins/tests.lua
--
-- @brief
-- The file to set option for tests
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-12-01
--


local opts = {}


opts.language_config = {

  python = {

    executable = 'pytest',
    makeprg = 'pytest \\| grep "Error$"',
    errorformat = '%f:%l: %m',

  },

}


return {

  dir = vim.fn.stdpath('config') .. '/projects/tests.lua',

  event = 'UIEnter',

  config = function()

    local success, tests = pcall(require, 'tests')
    if not success then
      vim.notify('Failed to load plugin: test')
      return
    end

    tests.setup(opts)

  end

}
