---
-- @file lua/profiles/rezha/plugins/gitsigns.lua
--
-- @brief
-- The configuration file for the plugin gitsigns
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-08-31
--


return {

  'lewis6991/gitsigns.nvim',

  event = {'BufReadPost', 'BufNewFile'},

  config = function()
    
    local success, gitsigns = pcall(require, 'gitsigns')
    if not success then
      vim.notify('Error loading plugin: gitsigns')
      return
    end

    gitsigns.setup {
      signs = {
        add = {text = '+'},
        change = {text = '*'},
        delete = {text = '-'},
        topdelete = {text = '-'},
        changedelete = {text = '*'},
      },
      signcolumn = false,
      numhl = false,
      linehl = false,
      word_diff = false,
      watch_gitdir = {
        interval = 1000,
        follow_files = true,
      },
      attach_to_untracked = true,
      current_line_blame = false,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol',
        delay = 1000,
        ignore_whitespace = true,
      },
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil,
      max_file_length = 10000,
      preview_config = {
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1,
      },
    }

    vim.keymap.set('n', '<leader>k', ':Gitsigns preview_hunk<CR>', {noremap = true, silent = true})
    vim.keymap.set('n', '<leader>u', ':Gitsigns reset_hunk<CR>', {noremap = true, silent = true})
    vim.keymap.set('n', '<leader>x', ':Gitsigns diffthis<CR>', {noremap = true, silent = true})

  end

}
