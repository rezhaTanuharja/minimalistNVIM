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

  config = function()

    vim.keymap.set("n", "<leader>ai", "<cmd>MoltenInit<return>", { noremap = true, silent = true, desc = "initialize molten"})

    local run_block = function()
      local node = vim.treesitter.get_node()
      local start_row, _, end_row, _ = vim.treesitter.get_node_range(node)
      vim.fn.MoltenEvaluateRange(start_row + 1, end_row)
    end

    vim.api.nvim_create_autocmd("User", {
      pattern = "MoltenInitPost",
      callback = function()

        vim.opt_local.colorcolumn="79"

        vim.keymap.set("n", "<leader>ar", run_block, { noremap = true, silent = true, desc = "reevaluate the current block"})

        vim.keymap.set("n", "<leader>am", "<cmd>MoltenReevaluateCell<return>", { noremap = true, silent = true, desc = "rerun cell"})
        vim.keymap.set("v", "<leader>am", ":<C-u>MoltenEvaluateVisual<return>", { noremap = true, silent = true, desc = "run highlighted code"})

        vim.keymap.set("n", "<leader>ao", "<cmd>MoltenShowOutput<return>", { noremap = true, silent = true, desc = "show outputs from the current cell"})
        vim.keymap.set("n", "<leader>ah", "<cmd>MoltenHideOutput<return>", { noremap = true, silent = true, desc = "hide outputs from the current cell"})
        vim.keymap.set("n", "<leader>al", "<cmd>MoltenEvaluateLine<return>", { noremap = true, silent = true, desc = "evaluate the current line"})
        vim.keymap.set("n", "<leader>an", "<cmd>MoltenNext<return>", { noremap = true, silent = true, desc = "move to the next cell"})
        vim.keymap.set("n", "<leader>ap", "<cmd>MoltenPrev<return>", { noremap = true, silent = true, desc = "move to the prev cell"})
        vim.keymap.set("n", "<leader>aa", "<cmd>MoltenReevaluateAll<return>", { noremap = true, silent = true, desc = "reevaluate all cells"})
        vim.keymap.set("n", "<leader>ae", ":noautocmd MoltenEnterOutput<return>", { noremap = true, silent = true, desc = "enter the output window"})
        vim.keymap.set("n", "<leader>af", "<cmd>MoltenImagePopup<return>", { noremap = true, silent = true, desc = "open image in a new window"})
        vim.keymap.set("n", "<leader>as", "<cmd>MoltenDeinit<return>", { noremap = true, silent = true, desc = "stop molten"})
      end,
    })

  end,

}
