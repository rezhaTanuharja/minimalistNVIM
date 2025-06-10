---
-- @file lua/plugins/nvim-tree.lua
--
-- @brief
-- The configuration file for the plugin nvim-tree
--
-- @author Tanuharja, R.A.
-- @date 2024-08-31
--


return {

  "kyazdani42/nvim-tree.lua",

  keys = {
    { "<leader>ee", "<cmd>NvimTreeToggle<return>" },
    { "<leader>eo", "<cmd>NvimTreeFindFile<return>" },
  },

  opts = {
    update_focused_file = {
      enable = false,
      update_cwd = false,
    },

    renderer = {

      root_folder_modifier = ":t",

      icons = {

        diagnostics_placement = "signcolumn",
        git_placement = "after",

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
            unstaged = "*",
            staged = "+",
            deleted = "-",
            unmerged = "+",
            renamed = "*",
            untracked = "?",
            ignored = "i",
          },

        },

      },

    },

    diagnostics = {

      enable = true,
      show_on_dirs = true,
      show_on_open_dirs = false,

      icons = {
        hint = "?",
        info = "*",
        warning = "!",
        error = "!",
      },

    },

    git = {
      enable = true,
      show_on_dirs = true,
      show_on_open_dirs = false,
    },

    view = {
      width = 32,
      side = "left",
    },

    filters = {
      dotfiles = true,
      custom = { ".*cache.*" },
    },
  },

}
