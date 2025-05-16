return {
  "benlubas/molten-nvim",
  version = "^1.0.0",

  ft = {"python", "quarto"},

  dependencies = {

    "3rd/image.nvim",

    opts = {
      backend = "kitty",
      integrations = {},
      max_width = 100,
      max_height = 12,
      max_height_window_percentage = math.huge,
      max_width_window_percentage = math.huge,
      window_overlap_clear_enabled = true,
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
    },

  },

  build = ":UpdateRemotePlugins",

  init = function()
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 20
  end,

}
