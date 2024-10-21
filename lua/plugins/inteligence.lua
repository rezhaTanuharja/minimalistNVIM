return {

  dir = '~/.config/nvim/lua/projects/diagnostics.lua',

  event = 'UIEnter',

  dependencies = {
    {
      dir = '~/.config/nvim/lua/projects/languageservers.lua',
      config = function()
        require('projects.languageservers').setup {
          lua = true,
          Python = true,
        }
      end
    }
  },

  config = function()
    require('projects.diagnostics').setup {
      virtual_text = false,
      severity_sort = true,
      update_in_insert = false,
    }
  end

}
