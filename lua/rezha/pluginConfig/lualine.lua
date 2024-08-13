---
-- @file lua/rezha/pluginConfig/lualine.lua
--
-- @brief
-- The configuration file for the plugin lualine
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-08-13
--

local success, lualine = pcall(require, "lualine")
if not success then
  vim.notify("Error loading plugin: lualine")
  return
end

local diagnostics = {
  "diagnostics",
  sources = {"nvim_diagnostic"},
  sections = {"error", "warn", "hint"},
  symbols = {error = "E", warn = "W", hint = "H"},
  colored = false,
  update_in_insert = false,
  always_visible = true,
}

local mode = {
  "mode",
  fmt = function(str)
    return "-- " .. str .. " --"
  end,
}

local filetype = {
  "filetype",
  icons_enabled = false,
  icon = nil,
}

local branch = {
  "branch",
  icons_enabled = false,
  icon = nil,
}

lualine.setup {
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = {left = "", right = ""},
    section_separators = {left = "", right = ""},
    disabled_filetypes = {"alpha", "dashboard", "NvimTree", "Outline"},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {branch, diagnostics},
    lualine_b = {mode},
    lualine_c = {},
    lualine_x = {"encoding", filetype},
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
