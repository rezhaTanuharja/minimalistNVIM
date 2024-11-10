return {

  dir = vim.fn.stdpath('config') .. '/projects/statusline.lua',

  event = 'UIEnter',

  config = function()
    require('statusline').setup {
      single_cursorline = true,
      flavour = 'grayscale',
    }
  end

}
