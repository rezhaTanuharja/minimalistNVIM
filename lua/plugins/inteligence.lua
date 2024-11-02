return {

  dir = '~/.config/nvim/lua/projects/diagnostics.lua',

  ft = { 'lua', 'python' },

  dependencies = {
    {
      dir = '~/.config/nvim/lua/projects/languageservers.lua',
      config = function()

        local lsp = require('projects.languageservers')

        lsp.setup {
          lua = true,
          Python = true,
        }

        vim.keymap.set('n', '<leader>l', lsp.list_servers )

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
