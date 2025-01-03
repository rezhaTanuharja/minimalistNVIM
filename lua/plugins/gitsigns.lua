---
-- @file lua/plugins/gitsigns.lua
--
-- @brief
-- The configuration file for the plugin gitsigns
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-08-31
--


return {

  'lewis6991/gitsigns.nvim',

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

      signcolumn = true,
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

    vim.keymap.set('n', '<leader>k', gitsigns.preview_hunk)
    vim.keymap.set('n', '<leader>u', gitsigns.reset_hunk)
    vim.keymap.set('n', '<leader>x', gitsigns.diffthis)
    vim.keymap.set('n', '<leader>z', '<cmd>wincmd p | q<return>')

    vim.keymap.set('n', '<C-g>', gitsigns.stage_hunk)
    vim.keymap.set('n', '<C-f>', gitsigns.stage_buffer)
    vim.keymap.set('n', '<C-i>', gitsigns.blame_line)

    vim.keymap.set('n', 'gnh', function() gitsigns.nav_hunk('next') end)
    vim.keymap.set('n', 'gph', function() gitsigns.nav_hunk('prev') end)

    vim.api.nvim_set_hl(0, 'DiffAdd', { fg = '#DDDDDD' })
    vim.api.nvim_set_hl(0, 'DiffDelete', { fg = '#999999' })
    vim.api.nvim_set_hl(0, 'DiffText', { fg = '#000000', bg = '#BBBBBB' })
    vim.api.nvim_set_hl(0, 'Changed', { fg = '#EEEEEE' })

    vim.api.nvim_set_hl(0, 'GitSignsAddInline', { fg = '#EEEEEE', bg = '#444444' })
    vim.api.nvim_set_hl(0, 'GitSignsDeleteInline', { fg = '#AAAAAA', bg = '#333333' })
    vim.api.nvim_set_hl(0, 'GitSignsStagedAdd', { fg = '#AAAAAA' })
    vim.api.nvim_set_hl(0, 'GitSignsStagedChange', { fg = '#AAAAAA' })
    vim.api.nvim_set_hl(0, 'GitSignsStagedChangeDelete', { fg = '#AAAAAA' })

  end

}
