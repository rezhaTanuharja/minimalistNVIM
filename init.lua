---
-- @file init.lua
--
-- @brief
-- The starting point of the Neovim config
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-10-12
--


-- add projects path so they can be "required"

local projects_directory = vim.fn.stdpath('config') .. '/projects/'
package.path = package.path .. ';' .. projects_directory .. '?.lua'


-- list of all unnecessary providers

local disabled_providers = {
  'node',
  'perl',
  'python3',
  'ruby',
}

for _, provider in pairs(disabled_providers) do
  vim.g['loaded_' .. provider .. '_provider'] = 0
end


-- list of all config files

local config_files = {
  'options',
  'keymaps',
  'plugins',
}

for _, file in pairs(config_files) do

  local success = pcall(require, file)
  if not success then
    vim.notify('Failed to load a config file ' .. file)
    break
  end

end
