---
-- @file lua/init.lua
--
-- @brief
-- The configuration file to set some colors
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-09-23
--


local set_color = vim.api.nvim_set_hl

set_color(0, 'Normal', { fg = '#cccccc' })
set_color(0, 'Comment', { fg = '#555555', italic = false })
set_color(0, 'String', { fg = '#bbbbbb', italic = false })
set_color(0, 'Function', { fg = '#aaaaaa', italic = false })

set_color(0, 'Search', { fg = '#000000', bg = '#FFFFFF' })
set_color(0, 'CurSearch', { fg = '#000000', bg = '#FFFFFF' })

set_color(0, 'Identifier', { fg = '#999999', italic = false })
set_color(0, 'Special', { fg = '#777777', italic = false })
set_color(0, 'Question', { fg = '#666666', italic = false })

set_color(0, 'Directory', { fg = '#777777', italic = false })
set_color(0, 'NvimTreeFolderIcon', { fg = '#777777', italic = false })

set_color(0, 'DiffAdd', { fg = '#dddddd', italic = false })
set_color(0, 'DiffDelete', { fg = '#888888', italic = false })
set_color(0, 'DiffText', { fg = '#000000', bg = '#bbbbbb', italic = false })
set_color(0, 'Changed', { fg = '#eeeeee', italic = false })
