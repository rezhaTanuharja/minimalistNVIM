---
-- @file lua/rezha/colorscheme.lua
--
-- @brief
-- The configuration file for color scheme
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-08-13
--

local colorScheme = "catppuccin-mocha"

local success, _ = pcall(vim.cmd, "colorscheme " .. colorScheme)
if not success then
  vim.notify("Error loading colorscheme: " .. colorScheme)
  return
end
