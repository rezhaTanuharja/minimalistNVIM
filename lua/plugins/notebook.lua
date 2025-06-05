---
-- @file lua/plugins/notebook.lua
--
-- @brief
-- The configuration file for the notebook plugin
--
-- @author Tanuharja, R.A.
-- @date 2025-06-05
--


local opts = {}


opts.keymaps = {

  convert_to_normal_script = "<leader>aj",
  move_import_to_top = "<leader>ak",

  activate_otter = "<leader>op",

  initialize_molten = "<leader>ai",
  stop_molten = "<leader>as",

  execute_block = "<leader>ar",

  enter_output = "<leader>ae",
  hide_output = "<leader>ah",
  image_popup = "<leader>af",

  reevaluate_all = "<leader>aa",
  evaluate_visual = "<leader>am",
  evaluate_line = "<leader>al",

  next_block = "<leader>an",
  prev_block = "<leader>ap",

}


opts.custom_highlights = {

  ["@markup.raw.block.markdown"] = {},
  ["@label.markdown"]            = { fg = "#555555" },
  ["@spell"]                     = { fg = "#888888" },

}


return {

  "notebook", dev = true,

  ft = { "quarto" },

  dependencies = {

    'nvim-treesitter/nvim-treesitter',

    {
      'jmbuhr/otter.nvim',

      opts = {
        lsp = {
          diagnostic_update_events = {
            "BufWritePost",
            "InsertLeave",
            "TextChanged"
          },
        },
      },
    },

    {

      "benlubas/molten-nvim",
      version = "^1.0.0",

      dependencies = {

        "3rd/image.nvim",

        opts = {
          backend = "kitty",
          integrations = {},
          max_width = 100,
          max_height = 40,
          max_height_window_percentage = math.huge,
          max_width_window_percentage = math.huge,
          window_overlap_clear_enabled = false,
          window_overlap_clear_ft_ignore = {},
        },

      },

      build = ":UpdateRemotePlugins",

      init = function()
        vim.g.molten_image_provider = "image.nvim"
        vim.g.molten_output_win_max_height = 40
        vim.g.molten_use_border = true
        vim.g.molten_auto_open_output = false
        vim.g.molten_image_location = "float"
        vim.g.molten_tick_rate = 200
      end,
    },

  },

  opts = opts,

}
