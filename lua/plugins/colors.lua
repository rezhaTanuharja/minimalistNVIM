return {

  dir = vim.fn.stdpath('config') .. '/projects/colors.lua',

  event = 'UIEnter',

  config = function()
    require('projects.colors').setup {
      flavour = 'grayscale',
    }
  end

}
