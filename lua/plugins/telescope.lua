---
-- @file lua/plugins/telescope.lua
--
-- @brief
-- The configuration file for the plugin telescope
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-11-12
--


return {

  'nvim-telescope/telescope.nvim',


  -- if server successfully starts then use fzf-lua instead

  cond = function()
    if not vim.g.fzf_lua_server then
      local success, server = pcall(vim.fn.serverstart, "fzf-lua." .. os.time())
      if success then
        vim.g.fzf_lua_server = server
      end
      return not success
    end
    return false
  end,


  event = 'UIEnter',

  dependencies = {

    'nvim-lua/plenary.nvim',

    {
      'nvim-telescope/telescope-fzf-native.nvim',

      build = 'make',

      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },

  },

  config = function()

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

    success, _ = pcall(telescope.load_extension, 'fzf')
    if not success then
      vim.notify('Failed to load telescope extension fzf')
      return
    end

    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>f', builtin.find_files, { noremap = true, silent = true })
    vim.keymap.set('n', '<leader>g', builtin.live_grep, { noremap = true, silent = true })

  end,

}
