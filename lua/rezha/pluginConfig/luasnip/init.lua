---
-- @file lua/rezha/pluginConfig/luasnip/init.lua
--
-- @brief
-- The configuration file for the plugin luasnip
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-08-26
--

local languages = {
  "python"
}

local location = "rezha.pluginConfig.luasnip"
local success

for _, language in pairs(languages) do
  success, _ = pcall(require, location .. ".snippets." .. language)
  if not success then
    vim.notify("Error loading snippet: " .. language)
  end
end
