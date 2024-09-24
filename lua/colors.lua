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
set_color(0, 'Search', { fg = '#000000', bg = '#FFFFFF' })
set_color(0, 'CurSearch', { fg = '#000000', bg = '#FFFFFF' })
set_color(0, 'Comment', { fg = '#555555', italic = false })
set_color(0, 'String', { fg = '#bbbbbb', italic = false })
set_color(0, 'Function', { fg = '#999999', italic = false })
set_color(0, 'Identifier', { fg = '#999999', italic = false })
set_color(0, 'Special', { fg = '#777777', italic = false })
set_color(0, 'Question', { fg = '#666666', italic = false })
set_color(0, 'Directory', { fg = '#777777', italic = false })
set_color(0, 'Directory', { fg = '#777777', italic = false })
set_color(0, 'NvimTreeFolderIcon', { fg = '#777777', italic = false })

set_color(0, 'lualine_a_normal', { fg = '#eeeeee', bg = '#555555' } )
set_color(0, 'lualine_b_normal', { fg = '#eeeeee', bg = '#333333' } )
set_color(0, 'lualine_c_normal', { fg = '#eeeeee', bg = '#222222' } )

set_color(0, 'lualine_a_insert', { fg = '#eeeeee', bg = '#555555' } )
set_color(0, 'lualine_b_insert', { fg = '#eeeeee', bg = '#333333' } )
set_color(0, 'lualine_c_insert', { fg = '#eeeeee', bg = '#333333' } )

set_color(0, 'lualine_a_visual', { fg = '#eeeeee', bg = '#555555' } )
set_color(0, 'lualine_b_visual', { fg = '#eeeeee', bg = '#333333' } )
set_color(0, 'lualine_c_visual', { fg = '#eeeeee', bg = '#555555' } )

set_color(0, 'lualine_a_command', { fg = '#eeeeee', bg = '#555555' } )
set_color(0, 'lualine_b_command', { fg = '#eeeeee', bg = '#333333' } )
set_color(0, 'lualine_c_command', { fg = '#eeeeee', bg = '#888888' } )
