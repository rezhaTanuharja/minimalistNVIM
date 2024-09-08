

return{

  'nvim-neorg/neorg',

  lazy = false,
  version = '*',

  dependencies = {
    'vhyrro/luarocks.nvim'
  },

  config = function()

    local success, neorg = pcall(require, 'neorg')
    if not success then
      vim.notify('Failed to load plugin: neorg')
      return
    end

    neorg.setup {

      load = {
        ['core.defaults'] = {},
        ['core.concealer'] = {
          config = {
            icons = {
              todo = {
                undone = { icon = ' ' },
                done = { icon = 'x' },
                urgent = { icon = '!' },
                uncertain = { icon = '?' },
              },
            },
          },
        },

        ['core.completion'] = {
          config = {
            engine = 'nvim-cmp',
          },
        },

        ['core.integrations.nvim-cmp'] = {},
        ['core.esupports.indent'] = {},
      }

    }

  end,

}
