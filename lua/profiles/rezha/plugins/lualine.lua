---
-- @file lua/profiles/rezha/plugins/lualine.lua
--
-- @brief
-- The configuration file for the plugin lualine
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-08-31
--


return {

  'nvim-lualine/lualine.nvim',

  event = 'InsertEnter',

  config = function()

    local success, lualine = pcall(require, 'lualine')
    if not success then
      vim.notify('Failed to load plugin: lualine')
      return
    end

    -- display the number of errors, warnings, and infos
    local diagnostics = {
      'diagnostics',
      sources = {'nvim_diagnostic'},
      sections = {'error', 'warn', 'hint'},
      symbols = {error = 'E', warn = 'W', hint = 'H'},
      colored = false,
      update_in_insert = false,
      always_visible = true,
    }

    -- display the current mode
    local mode = {
      'mode',
      fmt = function(str)
        return '-- ' .. str .. ' --'
      end,
    }

    -- display the active filetype
    local filetype = {
      'filetype',
      icons_enabled = false,
      icon = nil,
    }

    -- display the git branch
    local branch = {
      'branch',
      icons_enabled = false,
      icon = nil,
    }

    -- display cursor location (row and column)
    local location = {
      'location',
      padding = 0,
    }

    lualine.setup {

      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = {left = '', right = ''},
        section_separators = {left = '', right = ''},
        disabled_filetypes = {'alpha', 'dashboard', 'NvimTree', 'Outline'},
        always_divide_middle = true,
      },

      sections = {
        lualine_a = {branch, diagnostics},
        lualine_b = {mode},
        lualine_c = {},
        lualine_x = {'encoding', filetype},
        lualine_y = {},
        lualine_z = {location},
      },

      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },

      tabline = {},
      extensions = {},
    }

  end,
}
