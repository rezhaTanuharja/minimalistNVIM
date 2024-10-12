---
-- @file lua/plugins/gitsigns.lua
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

    vim.keymap.set('n', '<leader>k', ':Gitsigns preview_hunk<CR>')
    vim.keymap.set('n', '<leader>u', ':Gitsigns reset_hunk<CR>')
    vim.keymap.set('n', '<leader>x', ':vert Gitsigns diffthis<CR>')
    vim.keymap.set('n', '<leader>z', ':wincmd p | q<CR>')

    vim.keymap.set('n', '<C-g>', '<Cmd>Gitsigns stage_hunk<CR>')
    vim.keymap.set('n', '<C-h>', '<Cmd>Gitsigns stage_buffer<CR>')
    vim.keymap.set('n', '<C-i>', '<Cmd>Gitsigns blame_line<CR>')

    vim.api.nvim_set_hl(0, 'DiffAdd', { fg = '#dddddd' })
    vim.api.nvim_set_hl(0, 'DiffDelete', { fg = '#999999' })
    vim.api.nvim_set_hl(0, 'DiffText', { fg = '#000000', bg = '#bbbbbb' })
    vim.api.nvim_set_hl(0, 'Changed', { fg = '#eeeeee' })

    vim.api.nvim_set_hl(0, 'GitSignsAddInline', { fg = '#eeeeee', bg = '#444444' })
    vim.api.nvim_set_hl(0, 'GitSignsDeleteInline', { fg = '#aaaaaa', bg = '#333333' })
    vim.api.nvim_set_hl(0, 'GitSignsStagedAdd', { fg = '#aaaaaa' })
    vim.api.nvim_set_hl(0, 'GitSignsStagedChange', { fg = '#aaaaaa' })
    vim.api.nvim_set_hl(0, 'GitSignsStagedChangeDelete', { fg = '#aaaaaa' })

  end

}
