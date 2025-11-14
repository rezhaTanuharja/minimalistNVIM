---
-- @file lua/snippets/init.lua
--
-- @brief
-- The starting point of snippets
--
-- @author Tanuharja, R.A.
-- @date 2025-08-09
--

local M = {}

local cache = {}

_G.complete_snippets = function(findstart, base)
  local filetype = vim.bo.filetype
  local snippets = {}

  if not cache[filetype] then
    cache[filetype] = require("snippets." .. filetype)
  end

  snippets = cache[filetype]

  if findstart == 1 then
    local line = vim.fn.getline(".")
    local col = vim.fn.col(".") - 1
    local start = col
    while start > 0 and line:sub(start, start):match("[%w_-]") do
      start = start - 1
    end
    return start
  else
    local items = {}
    for key, body in pairs(snippets) do
      if key:match("^" .. vim.pesc(base)) then
        table.insert(items, {
          word = key,
          user_data = vim.fn.json_encode({ snippet = body }),
        })
      end
    end
    return items
  end
end

M.enable_snippets = function()
  local bufnr = vim.api.nvim_get_current_buf()

  vim.api.nvim_buf_set_option(bufnr, "completefunc", "v:lua.complete_snippets")

  vim.api.nvim_create_autocmd("CompleteDone", {
    buffer = bufnr,
    callback = function()
      if vim.v.event.reason ~= "accept" then
        return
      end

      local completed = vim.v.completed_item
      if not completed or not completed.user_data then
        return
      end

      local success, data = pcall(vim.fn.json_decode, completed.user_data)
      if not success or not data.snippet then
        return
      end

      vim.api.nvim_feedkeys(vim.keycode("<C-w>"), "n", false)

      vim.schedule(function()
        vim.snippet.expand(data.snippet)
      end)
    end,
  })
end

return M
