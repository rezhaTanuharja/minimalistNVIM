---
-- @file lua/internal_plugins/colors.lua
--
-- @brief
-- The configuration file to set some colors
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-09-23
--


local group_styles = {

  ['Normal']      = { fg = '#cccccc' },
  ['Comment']     = { fg = '#777777', italic = false },
  ['String']      = { fg = '#bbbbbb', italic = false },
  ['Function']    = { fg = '#bbbbbb', italic = false },
  ['Identifier']  = { fg = '#999999', italic = false },
  ['Special']     = { fg = '#bbbbbb', italic = false },
  ['Queston']     = { fg = '#666666', italic = false },

  ['MatchParen']     = { fg = '#ffffff', bold = true },

  ['WinSeparator'] = { fg = '#444444' },

  ['Folded']      = { fg = '#444444' },

  ['Search']      = { fg = '#000000', bg = '#777777' },
  ['CurSearch']   = { fg = '#000000', bg = '#aaaaaa' },

  ['DiagnosticInfo']   = { fg = '#999999' },
  ['DiagnosticHint']   = { fg = '#999999' },

  ['Directory']   = { fg = '#777777', italic = false },

  ['NvimTreeFolderIcon'] = { fg = '#777777', italic = false },

  ['DiffAdd']     = { fg = '#dddddd', italic = false },
  ['DiffDelete']  = { fg = '#999999', italic = false },
  ['DiffText']    = { fg = '#000000', bg = '#bbbbbb', italic = false },
  ['Changed']     = { fg = '#eeeeee', italic = false },

  ['GitSignsAddInline']     = { fg = '#eeeeee', bg = '#444444', italic = false },
  ['GitSignsDeleteInline']  = { fg = '#aaaaaa', bg = '#333333', italic = false },
  ['GitSignsStagedAdd']     = { fg = '#aaaaaa', italic = false },

  ['MoreMsg']       = { fg = '#eeeeee', bg = '#444444', italic = false },
  ['Question']      = { fg = '#eeeeee', bg = '#444444', italic = false },
  ['QuickFixLine']  = { fg = '#eeeeee', bg = '#444444', italic = false },

}

for group, style in pairs(group_styles) do
  vim.api.nvim_set_hl(0, group, style)
end
