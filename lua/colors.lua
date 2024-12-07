local group_styles = {

  ['Normal']        = { fg = '#CCCCCC', bg = 'None' },
  ['NormalFloat']   = { fg = '#CCCCCC', bg = 'None' },
  ['String']        = { fg = '#BBBBBB' },
  ['Comment']       = { fg = '#777777' },
  ['Identifier']    = { fg = '#DDDDDD', bold = true },
  ['Statement']     = { fg = '#EEEEEE', bold = true },
  ['Function']      = { fg = '#FFFFFF' },
  ['Special']       = { fg = '#BBBBBB', bold = true },
  ['Constant']      = { fg = '#CCCCCC' },
  ['@variable']     = { fg = '#CCCCCC' },

  ['Question']      = { fg = '#666666' },
  ['Directory']     = { fg = '#777777' },

  ['MsgSeparator']  = { fg = '#EEEEEE', bg = '#444444' },
  ['MoreMsg']       = { fg = '#EEEEEE', bg = '#444444' },
  ['QuickFixLine']  = { fg = '#EEEEEE', bg = '#444444' },
  ['StatusLine']    = { fg = '#888888', bg = '#222222' },

  ['Folded']        = { fg = '#444444' },
  ['MatchParen']    = { fg = '#FFFFFF', bold = true },
  ['WinSeparator']  = { fg = '#444444' },

  ['Search']        = { fg = '#000000', bg = '#777777' },
  ['CurSearch']     = { fg = '#000000', bg = '#AAAAAA' },

  ['DiagnosticUnnecessary'] = { fg = '#BBBBBB' },

  ['@comment.warning']  = { fg = '#000000', bg = 'NvimLightYellow', bold = true },
  ['@comment.error']    = { fg = '#000000', bg = 'NvimLightRed', bold = true },
  ['@comment.note']     = { fg = '#000000', bg = '#D3EDE7', bold = true },

  ['LspSignatureActiveParameter'] = { bg = 'None' },
}

for group, style in pairs(group_styles) do
  vim.api.nvim_set_hl(0, group, style)
end
