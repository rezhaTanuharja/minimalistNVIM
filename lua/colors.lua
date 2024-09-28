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

local group_styles = {

  ['Normal']      = { fg = '#cccccc' },
  ['Comment']     = { fg = '#555555', italic = false },
  ['String']      = { fg = '#bbbbbb', italic = false },
  ['Function']    = { fg = '#aaaaaa', italic = false },
  ['Identifier']  = { fg = '#999999', italic = false },
  ['Special']     = { fg = '#777777', italic = false },
  ['Queston']     = { fg = '#666666', italic = false },

  ['Search']      = { fg = '#000000', bg = '#777777' },
  ['CurSearch']   = { fg = '#000000', bg = '#aaaaaa' },

  ['DiagnosticInfo']   = { fg = '#999999' },
  ['DiagnosticHint']   = { fg = '#999999' },

  ['Directory']   = { fg = '#777777', italic = false },

  ['NvimTreeFolderIcon'] = { fg = '#777777', italic = false },

  ['DiffAdd']     = { fg = '#dddddd', italic = false },
  ['DiffDelete']  = { fg = '#888888', italic = false },
  ['DiffText']    = { fg = '#000000', bg = '#bbbbbb', italic = false },
  ['Changed']     = { fg = '#eeeeee', italic = false },

  ['GitSignsAddInline']     = { fg = '#eeeeee', bg = '#444444', italic = false },
  ['GitSignsDeleteInline']  = { fg = '#aaaaaa', bg = '#333333', italic = false },

}

for group, style in pairs(group_styles) do
  set_color(0, group, style)
end
