---
-- @file lua/rezha/colorscheme.lua
--
-- @brief
-- The configuration file for color scheme
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-08-13
--

local colorScheme = "tokyonight-night"

local success, tokyonight = pcall(require, "tokyonight")
if not success then
  vim.notify("Error loading tokyonight setup")
  return
end

tokyonight.setup {
  on_colors = function(colors)
    colors.yellow = "#b7f5e9"
  end
}

success, _ = pcall(vim.cmd, "colorscheme " .. colorScheme)
if not success then
  vim.notify("Error loading colorscheme: " .. colorScheme)
  return
end
