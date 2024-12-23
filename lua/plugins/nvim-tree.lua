---
-- @file lua/plugins/nvim-tree.lua
--
-- @brief
-- The configuration file for the plugin nvim-tree
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-08-31
--


return {

  'kyazdani42/nvim-tree.lua',

  keys = {
    { '<leader>e', '<cmd>NvimTreeToggle<return>'},
  },

  config = function()

    local success, nvim_tree = pcall(require, 'nvim-tree')
    if not success then
      vim.notify('Failed to load plugin: nvim-tree')
      return
    end

    nvim_tree.setup {

      update_focused_file = {
        enable = false,
        update_cwd = false,
      },

      renderer = {

        root_folder_modifier = ':t',

        icons = {

          diagnostics_placement = 'signcolumn',
          git_placement = 'after',

          glyphs = {

            default = 'x',
            symlink = 's',

            folder = {
              arrow_open = '',
              arrow_closed = '',
              default = '[x]',
              open = ']x[',
              empty = '[ ]',
              empty_open = '] [',
              symlink = '[s]',
              symlink_open = ']s[',
            },

            git = {
              unstaged = '*',
              staged = '',
              deleted = '',
              unmerged = '',
              renamed = '',
              untracked = '',
              ignored = '',
            },

          },

        },

      },

      diagnostics = {

        enable = true,
        show_on_dirs = true,
        show_on_open_dirs = false,

        icons = {
          hint = '?',
          info = '*',
          warning = '!',
          error = '!',
        },

      },

      git = {

        enable = false,
        show_on_dirs = false,
        show_on_open_dirs = false,

      },

      -- adjust the window size
      view = {
        width = 32,
        side = 'left',
      },

      -- do not show hidden files
      filters = {
        dotfiles = true,
        custom = { '.*cache.*' },
      },

    }

    vim.api.nvim_set_hl(0, 'NvimTreeFolderIcon', { fg = '#777777'})


    -- when project structure / element changes, refresh all buffers

    local api = require('nvim-tree.api')
    local Event = api.events.Event

    vim.keymap.set('n', '<leader>e', api.tree.toggle)

    local events = {
      Event.NodeRenamed,
      Event.FileCreated,
      -- Event.FileRemoved,
      -- Event.FolderRemoved,
    }

    for _, event in pairs(events) do
      api.events.subscribe(
        event,

        function(_)

          vim.keymap.set('n', '<leader>e',

            function()
              api.tree.toggle()
              require('developers.languageservers').refresh()
              vim.keymap.set('n', '<leader>e', api.tree.toggle)
            end

          )

        end

      )
    end

  end,
}
