---
-- @file lua/rezha/pluginConfig/telescope.lua
--
-- @brief
-- The configuration file for the plugin telescope
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-08-13
--

local success, telescope = pcall(require, "telescope")
if not success then
  vim.notify("Error loading plugin: telescope")
  return
end

local actions
success, actions = pcall(require, "telescope.actions")
if not success then
  vim.notify("Error loading plugin: telescope.action")
  return
end

telescope.setup {
  defaults = {
    prompt_prefix = "",
    selection_caret = "  ",
    path_display = {"full"},

    mappings = {
      i = {},
      n = {
        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
      },
    },
    file_ignore_patterns = {
      "%.bin",
      "%.cmake",
      "%.check_cache",
      "%.dir",
      "%.docx",
      "%.gif",
      "%.jpg",
      "%.jpeg",
      "%.key",
      "%.make",
      "%.marks",
      "%.md",
      "%.o",
      "%.out",
      "%.pdf",
      "%.png",
      "%.pptx",
      "%.pyc",
      "%.so",
      "%.vtu",
      "%.wav",
      "%.xlsx",
      "%.yaml",
      "%.yml",
    },
  },
  pickers = {
    planets = {
      show_pluto = true,
    },
  },
  extensions = {
  },
}
