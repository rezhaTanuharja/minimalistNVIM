local create_block = function()
  local block = {
    "```{${1:language}}",
    "$0",
    "```",
  }

  vim.snippet.expand(table.concat(block, "\n"))
end

vim.keymap.set("n", "<leader>sb", create_block, { buffer = true })
