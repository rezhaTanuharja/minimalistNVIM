---
-- @file lua/internal_plugins/init.lua
--
-- @brief
-- The initialization file to load internal plugins
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-10-03
--


local function load_internal_plugins(filename)

  local success, _ = pcall(require, 'internal_plugins/' .. filename)
  if not success then
    vim.notify('Failed to load internal plugin ' .. filename)
  end

end

local internal_plugins = {
  'colors',
  'statusline',
}

for _, plugin in pairs(internal_plugins) do
  load_internal_plugins(plugin)
end
