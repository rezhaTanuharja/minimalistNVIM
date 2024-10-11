---
-- @file lua/internal_plugins/init.lua
--
-- @brief
-- The initialization file to load internal plugins
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-10-03
--


local internal_plugins = {
  'colors',
  'statusline',
}

for _, plugin in pairs(internal_plugins) do

  local success, _ = pcall(require, 'internal_plugins/' .. plugin)
  if not success then
    vim.notify('Failed to load the internal plugin ' .. plugin)
  end
  
end
