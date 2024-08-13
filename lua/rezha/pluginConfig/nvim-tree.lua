---
-- @file lua/rezha/pluginConfig/nvim-tree.lua
--
-- @brief
-- The configuration file for the plugin nvim-tree
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-08-13
--

local success, nvim_tree = pcall(require, "nvim-tree")
if not success then
  vim.notify("Error loading plugin: nvim-tree")
  return
end

nvim_tree.setup {
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  renderer = {
    root_folder_modifier = ":t",
    icons = {
      glyphs = {
        default = "x",
        symlink = "s",
        folder = {
          arrow_open = "",
          arrow_closed = "",
          default = "[x]",
          open = "]x[",
          empty = "[ ]",
          empty_open = "] [",
          symlink = "[s]",
          symlink_open = "]s[",
        },
        git = {
          unstaged = "",
          staged = "",
          deleted = "",
          unmerged = "",
          renamed = "",
          untracked = "",
          ignored = "",
        },
      },
    },
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = "H",
      info = "I",
      warning = "W",
      error = "E",
    },
  },
  view = {
    width = 32,
    side = "left",
  },
}
