---
-- @file lua/profiles/rezha/plugins/neorg.lua
--
-- @brief
-- The configuration file for the plugin neorg
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-09-08
--


return{

  'nvim-neorg/neorg',

  -- lazy = false,
  event = 'UIEnter',
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
        ['core.keybinds'] = {},

        ['core.concealer'] = {

          config = {

            -- enable folding
            folds = true,

            -- simplify the icons
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
        ['core.esupports.hop'] = {},

      },

    }

    -- custom binding that only works inside .neorg files
    vim.api.nvim_create_autocmd(
      'FileType', {
        pattern = 'norg',
        callback = function()

          -- jump to the linked item
          vim.api.nvim_buf_set_keymap(0, 'n', '<CR>', '<Plug>(neorg.esupports.hop.hop-link)', { noremap = true, silent = true })

          -- o for unfold all, i for fold all
          vim.api.nvim_buf_set_keymap(0, 'n', '<leader>o', 'zR', { noremap = true, silent = true })
          vim.api.nvim_buf_set_keymap(0, 'n', '<leader>i', 'zM', { noremap = true, silent = true })

          -- correct all indentation in the current buffer
          vim.api.nvim_buf_set_keymap(0, 'n', '<leader><leader>', 'gg=G', { noremap = true, silent = true })

          -- convert between finished and unfinished items
          vim.api.nvim_buf_set_keymap(0, 'x', '>>', ':s/( )/(x)<CR>:nohlsearch<CR>', { noremap = true, silent = true})
          vim.api.nvim_buf_set_keymap(0, 'x', '<<', ':s/(x)/( )<CR>:nohlsearch<CR>', { noremap = true, silent = true})

        end,
      }
    )


  end,

}
