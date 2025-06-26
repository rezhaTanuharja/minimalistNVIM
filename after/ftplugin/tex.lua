---
-- @file after/ftplugin/tex.lua
--
-- @brief
-- LaTeX - specific config
--
-- @author Tanuharja, R.A.
-- @date 2025-06-24
--

if vim.fn.executable("texlab") then
  vim.lsp.enable("texlab")
end

local create_skeleton = function()
  local skeleton = {
    "\\documentclass{${1:type}}",
    " ",
    "${2:% preambles}",
    " ",
    "\\begin{document}",
    " ",
    "$0",
    " ",
    "\\end{document}",
  }

  vim.snippet.expand(table.concat(skeleton, "\n"))
end

local create_environment = function()
  local environment = {
    "\\begin{${1:env}}",
    "\t$0",
    "\\end{${1}}",
  }

  vim.snippet.expand(table.concat(environment, "\n"))
end


vim.keymap.set("n", "<leader>ss", create_skeleton, { buffer = true })
vim.keymap.set("n", "<leader>se", create_environment, { buffer = true })
