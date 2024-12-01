return {

  dir = vim.fn.stdpath('config') .. '/projects/tests.lua',

  event = 'UIEnter',

  config = function()

    local success, tests = pcall(require, 'tests')
    if not success then
      vim.notify('Failed to load plugin: test')
      return
    end

    tests.setup {

      trigger = '<leader>t',

      python = {

        makeprg = 'pytest \\| grep "Error$"',
        errorformat = '%f:%l: %m',

      },

    }

  end

}
