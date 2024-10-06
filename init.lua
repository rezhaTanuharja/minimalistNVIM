---
-- @file init.lua
--
-- @brief
-- The initialization file to select user and call other configuration files
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-08-13
--


local config_files = {
  'globals',
  'options',
  'keymaps',
  'commands',
  'external_plugins',
  'internal_plugins',
}

for _, config_file in pairs(config_files) do

  local success, _ = pcall(require, config_file)
  if not success then
    vim.notify('Failed to load config file ' .. config_file)
    break
  end
  
end
