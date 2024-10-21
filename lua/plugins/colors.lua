return {

  dir = '~/.config/nvim/lua/projects/colors.lua',

  event = 'UIEnter',

  config = function()
    require('projects.colors').setup {
      flavour = 'grayscale',
    }
  end

}
