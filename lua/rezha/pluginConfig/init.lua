---
-- @file lua/rezha/pluginConfig/init.lua
--
-- @brief
-- The initialization file to call plugin configuration files
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-08-13
--

local location = "rezha.pluginConfig"

require(location .. ".autopairs")
require(location .. ".blankline")
require(location .. ".bufferline")
require(location .. ".cmp")
require(location .. ".gitsigns")
require(location .. ".lsp")
require(location .. ".lualine")
require(location .. ".nvim-tree")
require(location .. ".telescope")
require(location .. ".treesitter")
