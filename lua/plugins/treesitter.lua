---
-- @file lua/plugins/treesitter.lua
--
-- @brief
-- The configuration file for the plugin treesitter
--
-- @author Tanuharja, R.A.
-- @date 2024-08-31
--


return {

  "nvim-treesitter/nvim-treesitter",

  event = "UIEnter",

  build = ":TSUpdate",
  main = "nvim-treesitter.configs",

  config = function()

    local success, treesitter = pcall(require, "nvim-treesitter.configs")
    if not success then
      vim.notify("Failed to load plugin: treesitter")
      return
    end

    treesitter.setup {

      ensure_installed = {
        "cpp",
        "javascript",
        "latex",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
      },
      sync_install = true,
      ignore_install = {},

      highlight = {
        enable = true,
        disable = function(_, bufnr)
          return vim.api.nvim_buf_line_count(bufnr) > 2000
        end,
      },

      indent = {
        enable = true,
        disable = function(_, bufnr)
          return vim.api.nvim_buf_line_count(bufnr) > 2000
        end,
      },

      fold = {
        enable = { "python" },
        disable = function(_, bufnr)
          return vim.api.nvim_buf_line_count(bufnr) > 2000
        end,
      },

      incremental_selection = {
        enable = true,
        disable = function(_, bufnr)
          return vim.api.nvim_buf_line_count(bufnr) > 2000
        end,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },

    }

    vim.g._ts_force_sync_parsing = true

  end

}
