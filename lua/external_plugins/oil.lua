---
-- @file lua/external_plugins/oil.lua
--
-- @brief
-- The configuration file for the plugin oil
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-09-29
--


return {

  'stevearc/oil.nvim',

  opts = {},
  dependencies = {},

  config = function ()

    local success, oil = pcall(require, 'oil')
    if not success then
      vim.notify('Failed to load plugin: oil')
      return
    end

    oil.setup {

      default_file_explorer = true,

      columns = {
        -- 'icon',
        -- 'permissions',
        -- 'size',
        -- 'mtime',
      },

      buf_options = {},
      win_options = {},

      delete_to_trash = false,
      skip_confirm_for_simple_edits = false,
      watch_for_changes = false,

      keymaps = {
        ['<CR>'] = 'actions.select',
        ['-'] = 'actions.parent',
        ['_'] = 'actions.open_cwd',
      },

      use_default_keymaps = false,

      view_options = {
        show_hidden = false,
        natural_order = false,
        sort = {
          { 'type', 'asc' },
          { 'name', 'asc' },
        },
      },

    }

    vim.keymap.set('n', '<leader>o', ':Oil<CR>', { noremap = true, silent = true } )

  end
}
