---
-- @file init.lua
--
-- @brief
-- The initialization file to select user and call other configuration files
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-08-13
--


-- enable multiple profiles
local user = 'rezha'

-- a function to load config files
local function loadConfig(filename)

  -- use protected call so if something fails it does not crash
  local success, _ = pcall(require, filename)
  if not success then
    vim.notify('Failed to load a configuration file: ' .. filename)
  end

end

-- list all available config files
local configs = {
  'globals',
  'options',
  'keymaps',
  'commands',
  'lazy',
}

-- load all listed config files
for _, config in pairs(configs) do
  loadConfig('profiles.' .. user .. '.' .. config)
end
