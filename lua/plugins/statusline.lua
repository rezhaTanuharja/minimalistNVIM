return {

  dir = '~/.config/nvim/lua/projects/statusline.lua',

  event = 'UIEnter',

  config = function()
    require('projects.statusline').setup {
      single_cursorline = true,
      flavour = 'grayscale',
    }
  end

}
