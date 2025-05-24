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
      callback = function(arg)

        vim.opt_local.colorcolumn="80"

        vim.keymap.set("n", "<leader>ar", run_block, { buffer = arg.buf, desc = "reevaluate the current block"})

        vim.keymap.set("n", "<leader>am", "<cmd>MoltenReevaluateCell<return>", { buffer = arg.buf, desc = "rerun cell"})
        vim.keymap.set("v", "<leader>am", ":<C-u>MoltenEvaluateVisual<return>", { buffer = arg.buf, desc = "run highlighted code"})

        vim.keymap.set("n", "<leader>ao", "<cmd>MoltenShowOutput<return>", { buffer = arg.buf, desc = "show outputs from the current cell"})
        vim.keymap.set("n", "<leader>ah", "<cmd>MoltenHideOutput<return>", { buffer = arg.buf, desc = "hide outputs from the current cell"})
        vim.keymap.set("n", "<leader>al", "<cmd>MoltenEvaluateLine<return>", { buffer = arg.buf, desc = "evaluate the current line"})
        vim.keymap.set("n", "<leader>an", "<cmd>MoltenNext<return>", { buffer = arg.buf, desc = "move to the next cell"})
        vim.keymap.set("n", "<leader>ap", "<cmd>MoltenPrev<return>", { buffer = arg.buf, desc = "move to the prev cell"})
        vim.keymap.set("n", "<leader>aa", "<cmd>MoltenReevaluateAll<return>", { buffer = arg.buf, desc = "reevaluate all cells"})
        vim.keymap.set("n", "<leader>ae", ":noautocmd MoltenEnterOutput<return>", { buffer = arg.buf, desc = "enter the output window"})
        vim.keymap.set("n", "<leader>af", "<cmd>MoltenImagePopup<return>", { buffer = arg.buf, desc = "open image in a new window"})
        vim.keymap.set("n", "<leader>as", "<cmd>MoltenDeinit<return>", { buffer = arg.buf, desc = "stop molten"})

        vim.keymap.set(
          "n",
          "<leader>ad",
          function()
            vim.cmd("MoltenEvaluateArgument import debugpy")
            vim.cmd("MoltenEvaluateArgument _ = debugpy.listen(('localhost', 5678))")
          end,
          { buffer = arg.buf, desc = "initialize debugger"}
        )

        vim.keymap.set("n", "<leader>dd", "<cmd>MoltenEvaluateArgument debugpy.breakpoint()<return>", { buffer = arg.buf, desc = "enter virtual breakpoint"})

      end,
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "MoltenDeinitPost",
      callback = function(arg)

        vim.opt_local.colorcolumn=""

        vim.keymap.del("n", "<leader>ar", { buffer = arg.buf })

        vim.keymap.del("n", "<leader>am", { buffer = arg.buf })
        vim.keymap.del("v", "<leader>am", { buffer = arg.buf })

        vim.keymap.del("n", "<leader>ao", { buffer = arg.buf })
        vim.keymap.del("n", "<leader>ah", { buffer = arg.buf })
        vim.keymap.del("n", "<leader>al", { buffer = arg.buf })
        vim.keymap.del("n", "<leader>an", { buffer = arg.buf })
        vim.keymap.del("n", "<leader>ap", { buffer = arg.buf })
        vim.keymap.del("n", "<leader>aa", { buffer = arg.buf })
        vim.keymap.del("n", "<leader>ae", { buffer = arg.buf })
        vim.keymap.del("n", "<leader>af", { buffer = arg.buf })
        vim.keymap.del("n", "<leader>as", { buffer = arg.buf })

        vim.keymap.del("n", "<leader>ad", { buffer = arg.buf })
        vim.keymap.del("n", "<leader>dd", { buffer = arg.buf })

      end,
    })

  end,

}
