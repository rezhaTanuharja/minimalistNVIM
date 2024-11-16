return {

  dir = vim.fn.stdpath('config') .. '/projects/colors.lua',

  event = 'UIEnter',

  config = function()
    require('colors').setup {
      flavour = 'pistachio',
    }
  end

}
