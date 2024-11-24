return {

  dir = vim.fn.stdpath('config') .. '/projects/tests.lua',

  event = 'UIEnter',

  config = function()

    local success, tests = pcall(require, 'tests')
    if not success then
      vim.notify('Failed to load plugin: prompt')
      return
    end

    tests.setup {
      python = true,
      trigger = '<leader>t',
    }

  end

}
