---
-- @file lua/projects/colors.lua
--
-- @brief
-- The file to set highlight group's colors
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-10-12
--


local M = {}

M.setup = function(opts)

  local group_styles = {

    ['Comment']       = { fg = '#777777' },
    ['Identifier']    = { fg = '#DDDDDD', bold = true },
    ['Statement']     = { fg = '#EEEEEE', bold = true },

    ['Question']      = { fg = '#666666' },
    ['Directory']     = { fg = '#777777' },

    ['MsgSeparator']  = { fg = '#EEEEEE', bg = '#444444' },
    ['MoreMsg']       = { fg = '#EEEEEE', bg = '#444444' },
    ['QuickFixLine']  = { fg = '#EEEEEE', bg = '#444444' },
    ['StatusLine']    = { fg = '#888888', bg = '#222222' },
    ['NormalFloat']   = { bg = 'None' },

    ['Folded']        = { fg = '#444444' },
    ['MatchParen']    = { fg = '#FFFFFF', bold = true },
    ['WinSeparator']  = { fg = '#444444' },

    ['Search']        = { fg = '#000000', bg = '#777777' },
    ['CurSearch']     = { fg = '#000000', bg = '#AAAAAA' },

    ['DiagnosticUnnecessary'] = { fg = '#BBBBBB' },

  }

  if opts.flavour == 'pistachio' then

    group_styles['Normal']        = { fg = '#CCCCCC', bg = '#000000' }
    group_styles['String']        = { fg = '#909689' }
    group_styles['Function']      = { fg = '#7A7E82' }
    group_styles['Special']       = { fg = '#7A7E82' }

    group_styles['Constant']      = { fg = '#7A7E82' }
    group_styles['Type']          = { fg = '#7A7E82' }
    group_styles['PreProc']       = { fg = '#E3D8C8' }

    group_styles['@spell']        = { fg = '#777777' }
    group_styles['@variable']     = { fg = '#A9A9A4' }

  else

    group_styles['Normal']        = { fg = '#CCCCCC', bg = 'None' }
    group_styles['String']        = { fg = '#BBBBBB' }
    group_styles['Function']      = { fg = '#BBBBBB' }
    group_styles['Special']       = { fg = '#BBBBBB', bold = true }

  end

  for group, style in pairs(group_styles) do
    vim.api.nvim_set_hl(0, group, style)
  end


end

return M
