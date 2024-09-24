---
-- @file init.lua
--
-- @brief
-- The initialization file to select user and call other configuration files
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-08-13
--


-- a function to load config files
local function load_config(filename)

  -- use protected call so if something fails it does not crash
  local success, _ = pcall(require, filename)
  if not success then
    vim.notify('Failed to load a configuration file: ' .. filename)
  end

end

-- list all available config files
local config_files = {
  'globals',
  'options',
  'keymaps',
  'commands',
  'plugins',
  'colors',
}

-- load all listed config files
for _, config_file in pairs(config_files) do
  load_config(config_file)
end
