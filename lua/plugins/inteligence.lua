return {

  dir = vim.fn.stdpath('config') .. '/projects/diagnostics.lua',

  ft = { 'lua', 'python', 'cpp' },

  dependencies = {
    {
      dir = vim.fn.stdpath('config') .. '/projects/languageservers.lua',
      config = function()

        local lsp = require('languageservers')

        lsp.setup {
          lua = true,
          Python = true,
          cpp = true,
        }

        vim.keymap.set('n', '<leader>l', lsp.list_servers )

      end
    }
  },

  config = function()
    require('diagnostics').setup {
      virtual_text = false,
      severity_sort = true,
      update_in_insert = false,
    }
  end

}
