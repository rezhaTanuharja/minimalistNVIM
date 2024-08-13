---
-- @file init.lua
--
-- @brief
-- The initialization file to select user and call other configuration files
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-08-13
--

local user = "rezha"

local function loadConfig(filename)
  local success, _ = pcall(require, filename)
  if not success then
    vim.notify("Error loading configuration file: " .. filename)
  end
end

loadConfig(user .. ".colorscheme")
loadConfig(user .. ".keymaps")
loadConfig(user .. ".options")
loadConfig(user .. ".plugins")
loadConfig(user .. ".pluginConfig")
