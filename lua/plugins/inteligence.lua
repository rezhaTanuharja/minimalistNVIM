return {

  dir = vim.fn.stdpath('config') .. '/projects/languageservers.lua',

  ft = { 'lua', 'python', 'cpp' },

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
