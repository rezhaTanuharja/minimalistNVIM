---
-- @file lua/rezha/pluginConfig/bufferline.lua
--
-- @brief
-- The configuration file for the plugin bufferline
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-08-13
--

local success, bufferline = pcall(require, "bufferline")
if not success then
  vim.notify("Error loading plugin: bufferline")
  return
end

bufferline.setup { options = {
    numbers = "none",
    close_command = "Bdelete! %d",
    right_mouse_command = "Bdelete! %d",
    left_mouse_command = "buffer %d",
    middle_mouse_command = nil,
    indicator_icon = nil,
    indicator = {style = "icon", icon = "| "},
    buffer_close_icon = "x",
    modified_icon = "*",
    left_trunc_marker = "",
    right_trunc_marker = "",
    max_name_length = 30,
    max_prefix_length = 30,
    tab_size = 21,
    diagnostics = true,
    diagnostics_update_in_insert = true,
    offsets = {{filetype = "NvimTree", text = "", padding = 1}},
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    persist_buffer_sort = true,
    separator_style = "thin",
    enforce_regular_tabs = true,
    always_show_bufferline = false,
  },
--
--   highlights = {
--
--     fill = {
--       fg = {attribute = "fg", highlight = "Visual"},
--       bg = {attribute = "bg", highlight = "Tabline"},
--     },
--
--     background = {
--       fg = {attribute = "fg", highlight = "Tabline"},
--       bg = {attribute = "bg", highlight = "Tabline"},
--     },
--
--     buffer_visible = {
--       fg = {attribute = "fg", highlight = "Tabline"},
--       bg = {attribute = "bg", highlight = "Tabline"},
--     },
--
--     close_button = {
--       fg = {attribute = "fg", highlight = "Tabline"},
--       bg = {attribute = "bg", highlight = "Tabline"},
--     },
--
--     close_button_visible = {
--       fg = {attribute = "fg", highlight = "Tabline"},
--       bg = {attribute = "bg", highlight = "Tabline"},
--     },
--
--     tab_selected = {
--       fg = {attribute = "fg", highlight = "Normal"},
--       bg = {attribute = "bg", highlight = "Normal"},
--     },
--
--     tab = {
--       fg = {attribute = "fg", highlight = "Tabline"},
--       bg = {attribute = "bg", highlight = "Tabline"},
--     },
--
--     tab_close = {
--       fg = {attribute = "fg", highlight = "TablineSel"},
--       bg = {attribute = "bg", highlight = "Normal"},
--     },
--
--     duplicate_selected = {
--       fg = {attribute = "fg", highlight = "TablineSel"},
--       bg = {attribute = "bg", highlight = "TablineSel"},
--     },
--
--     duplicate_visible = {
--       fg = {attribute = "fg", highlight = "Tabline"},
--       bg = {attribute = "bg", highlight = "Tabline"},
--     },
--
--     duplicate = {
--       fg = {attribute = "fg", highlight = "Tabline"},
--       bg = {attribute = "bg", highlight = "Tabline"},
--     },
--
--     modified = {
--       fg = {attribute = "fg", highlight = "Tabline"},
--       bg = {attribute = "bg", highlight = "Tabline"},
--     },
--
--     modified_selected = {
--       fg = {attribute = "fg", highlight = "Normal"},
--       bg = {attribute = "bg", highlight = "Normal"},
--     },
--
--     modified_visible = {
--       fg = {attribute = "fg", highlight = "Tabline"},
--       bg = {attribute = "bg", highlight = "Tabline"},
--     },
--
--     separator = {
--       fg = {attribute = "fg", highlight = "Tabline"},
--       bg = {attribute = "bg", highlight = "Tabline"},
--     },
--
--     separator_selected = {
--       fg = {attribute = "fg", highlight = "Normal"},
--       bg = {attribute = "bg", highlight = "Normal"},
--     },
--
--     indicator_selected = {
--       fg = {attribute = "fg", highlight = "Normal"},
--       bg = {attribute = "bg", highlight = "Normal"},
--     },
--
--   },
--
}
