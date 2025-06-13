---
-- @file after/plugin/colors.lua
--
-- @brief
-- Change some of the highlight groups
--
-- @author Tanuharja, R.A.
-- @date 2024-12-20
--


local group_styles = {

  ["Normal"]        = { fg = "#CCCCCC", bg = "None" },
  ["NormalFloat"]   = { fg = "#CCCCCC", bg = "None" },

  ["String"]        = { fg = "#D6DFD4" },
  ["Comment"]       = { fg = "#777777" },

  ["Visual"]        = { bg = "#333333" },

  ["Identifier"]    = { fg = "#DDDDDD", bold = true },
  ["Statement"]     = { fg = "#EEEEEE", bold = true },
  ["Special"]       = { fg = "#999ECF", bold = false },

  ["Function"]      = { fg = "#999ECF" },
  ["Constant"]      = { fg = "#CCCCCC" },

  ["DiffAdd"]       = { fg = "None", bg = "#000022", sp = "None" },
  ["DiffDelete"]    = { fg = "#666666" },
  ["DiffText"]      = { fg = "NvimLightYellow", bg = "None", sp = "None" },
  ["DiffChange"]    = { fg = "None", bg = "None" },

  ["Changed"]       = { fg = "#EEEEEE", bg = "None" },
  
  ["Error"]         = { fg = "#FFFFFF", bg = "None", bold = true },

  ["QuickFixLine"]  = { fg = "#CCCCCC", bold = true },

  ["Pmenu"]         = { fg = "#DDDDDD", bg = "#222222"  },
  ["PmenuSel"]      = { fg = "#CCCCCC", bg = "#444444" },

  ["Question"]      = { fg = "#666666" },
  ["Directory"]     = { fg = "#777777" },

  ["MsgSeparator"]  = { fg = "#EEEEEE", bg = "#444444" },
  ["MoreMsg"]       = { fg = "#EEEEEE", bg = "#444444" },

  ["StatusLine"]    = { fg = "#EEEEEE", bg = "#333333" },

  ["Folded"]        = { fg = "#444444" },
  ["MatchParen"]    = { fg = "#FFFFFF", bold = true },
  ["WinSeparator"]  = { fg = "#444444" },

  ["Search"]        = { fg = "#000000", bg = "#777777" },
  ["CurSearch"]     = { fg = "#000000", bg = "#AAAAAA" },

  ["DiagnosticUnnecessary"] = { fg = "#888888" },

  ["Todo"]              = { fg = "NvimLightYellow", bg = "None", bold = true },

  ["@variable"]             = { fg = "#CCCCCC" },
  ["@string.documentation"] = { fg = "#777777" },
  ["@comment.warning"]      = { fg = "#000000", bg = "NvimLightYellow", bold = true },
  ["@comment.error"]        = { fg = "#000000", bg = "NvimLightRed", bold = true },
  ["@comment.note"]         = { fg = "#000000", bg = "#D3EDE7", bold = true },

  ["LspSignatureActiveParameter"] = { bg = "None" },

  ["NvimTreeGitDeletedIcon"] = { fg = "#999ECF", bg = "None" },
  ["NvimTreeGitDirtyIcon"]   = { fg = "#999ECF", bg = "None" },
  ["NvimTreeGitIgnoredIcon"] = { fg = "#999ECF", bg = "None" },
  ["NvimTreeGitMergeIcon"]   = { fg = "#999ECF", bg = "None" },
  ["NvimTreeGitNewIcon"]     = { fg = "#999ECF", bg = "None" },
  ["NvimTreeGitRenamedIcon"] = { fg = "#999ECF", bg = "None" },
  ["NvimTreeGitStagedIcon"]  = { fg = "#999ECF", bg = "None" },

}

for group, style in pairs(group_styles) do
  vim.api.nvim_set_hl(0, group, style)
end
