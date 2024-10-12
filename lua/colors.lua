local group_styles = {

  ['Normal']        = { fg = '#cccccc', bg = '#000000' },
  ['Comment']       = { fg = '#777777' },
  ['String']        = { fg = '#bbbbbb' },
  ['Function']      = { fg = '#bbbbbb' },
  ['Identifier']    = { fg = '#999999' },
  ['Special']       = { fg = '#bbbbbb' },
  ['Question']      = { fg = '#666666' },

  ['MoreMsg']       = { fg = '#eeeeee', bg = '#444444' },
  ['Question']      = { fg = '#eeeeee', bg = '#444444' },
  ['QuickFixLine']  = { fg = '#eeeeee', bg = '#444444' },

  ['MatchParen']    = { fg = '#ffffff', bold = true },
  ['WinSeparator']  = { fg = '#444444' },

  ['Search']        = { fg = '#000000', bg = '#777777' },
  ['CurSearch']     = { fg = '#000000', bg = '#aaaaaa' },

}

for group, style in pairs(group_styles) do
  vim.api.nvim_set_hl(0, group, style)
end
