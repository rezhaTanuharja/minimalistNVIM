---
-- @file lua/plugins/telescope.lua
--
-- @brief
-- The configuration file for the plugin telescope
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-08-31
--


return {

  -- githup repository for telescope
  'nvim-telescope/telescope.nvim',

  -- load when entering nvim
  event = 'UIEnter',

  -- specify dependencies of telescope
  dependencies = {

    'nvim-lua/plenary.nvim',

    {
      -- github repository for telescope-fzf-native
      'nvim-telescope/telescope-fzf-native.nvim',

      -- build using make
      build = 'make',

      -- require make to be installed
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },

  },

  config = function()

    -- use protected call to attempt to load telescope
    local success, telescope = pcall(require, 'telescope')
    if not success then
      vim.notify('Failed to load plugin: telescope')
      return
    end

    telescope.setup {

      defaults = {

        prompt_prefix = '',
        selection_caret = '  ',
        path_display = {'full'},
        scroll_strategy = 'limit',

        mappings = {
          i = {},
          n = {},
        },

        -- ignore file that is not supposed to be found through telescope
        file_ignore_patterns = {
          '.git/',
          '%.bin',
          '%.cmake',
          '%.check_cache',
          '%.dir',
          '%.docx',
          '%.gif',
          '%.jpg',
          '%.jpeg',
          '%.json',
          '%.key',
          '%.make',
          '%.marks',
          '%.md',
          '%.o',
          '%.out',
          '%.pdf',
          '%.png',
          '%.pptx',
          '%.pth',
          '%.pyc',
          '%.so',
          '%.vtu',
          '%.wav',
          '%.xlsx',
        },

      },
    }

    -- enable telescope extensions if they are installed
    success, _ = pcall(require('telescope').load_extension, 'fzf')
    if not success then
      vim.notify('Failed to load telescope extension fzf')
      return
    end

    -- custom keymaps for telescope
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>f', builtin.find_files)
    vim.keymap.set('n', '<leader>d', builtin.diagnostics)
    vim.keymap.set('n', '<leader>b', builtin.current_buffer_fuzzy_find)
    vim.keymap.set('n', '<leader>g', builtin.live_grep)
    vim.keymap.set('n', '<leader>s', builtin.grep_string)
    vim.keymap.set('n', '<leader>y', builtin.buffers)
  end,

}
