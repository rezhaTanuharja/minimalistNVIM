---
-- @file lua/profiles/rezha/plugins/bufferline.lua
--
-- @brief
-- The configuration file for the plugin bufferline
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-08-31
--


return {

  'akinsho/bufferline.nvim',

  event = 'UIEnter',

  dependencies = {
    'moll/vim-bbye',
  },

  config = function()

    local success, bufferline = pcall(require, "bufferline")
    if not success then
      vim.notify("Error loading plugin: bufferline")
      return
    end

    bufferline.setup {
      options = {
        mode = 'buffers',
        numbers = "none",
        close_command = "Bdelete! %d",
        right_mouse_command = "Bdelete! %d",
        left_mouse_command = "buffer %d",
        middle_mouse_command = nil,
        indicator_icon = nil,
        indicator = {style = "icon", icon = ""},
        buffer_close_icon = "",
        modified_icon = "*",
        left_trunc_marker = "",
        right_trunc_marker = "",
        name_formatter = function(buf)
          return path
        end,
        -- max_name_length = 30,
        -- max_prefix_length = 30,
        -- tab_size = 21,
        diagnostics = false,
        diagnostics_update_in_insert = false,
        offsets = {{filetype = "NvimTree", text = "NvimTree", separator = true, padding = 1}},
        show_buffer_icons = false,
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_tab_indicators = false,
        persist_buffer_sort = true,
        separator_style = {'', ''},
        enforce_regular_tabs = true,
        always_show_bufferline = true,
      },
    }

  end,

}
