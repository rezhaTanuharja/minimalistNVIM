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
local profile = 'rezha'

-- a function to load config files
local function loadConfig(filename)

  -- use protected call so if something fails it does not crash
  local success, _ = pcall(require, filename)
  if not success then
    vim.notify('Failed to load a configuration file: ' .. filename)
  end

end

-- vim.g.loaded_perl_provider = 0


-- load configuration files
loadConfig('profiles.' .. profile .. '.variables')
loadConfig('profiles.' .. profile .. '.options')
loadConfig('profiles.' .. profile .. '.keymaps')
loadConfig('profiles.' .. profile .. '.commands')
loadConfig('profiles.' .. profile .. '.lazy')
