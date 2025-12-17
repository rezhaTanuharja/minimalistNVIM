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

  config = function()
    local success, treesitter = pcall(require, "nvim-treesitter")
    if not success then
      vim.notify("Failed to load plugin: treesitter")
      return
    end

    treesitter.install({
      "cpp",
      "go",
      "html",
      "javascript",
      "json",
      "latex",
      "lua",
      "markdown_inline",
      "markdown",
      "python",
      "ruby",
      "tsx",
      "typescript",
    })
  end,
}
