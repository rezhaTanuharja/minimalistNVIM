---
-- @file lua/projects/snippets/init.lua
--
-- @brief
-- The configuration file for the snippet functionalities
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-10-05
--


local M = {}

local global_snippets = {}

local snippets_by_filetype = {

  lua = require('projects.snippets.lua'),
  python = require('projects.snippets.python'),

}

M.current_buffer_snippets = function()

  local filetype = vim.bo.filetype
  local buffer_snippets = vim.list_slice(global_snippets)

  if filetype and snippets_by_filetype[filetype] then
    vim.list_extend(buffer_snippets, snippets_by_filetype[filetype])
  end

  return buffer_snippets

end

M.register_cmp_source = function()

  local cmp_source = {}
  local cache = {}

  cmp_source.complete = function(_, _, callback)

    local bufnr = vim.api.nvim_get_current_buf()
    if not cache[bufnr] then

      local completion_items = vim.tbl_map(

        function(snippet)
          return {
            word = snippet.trigger,
            label = snippet.trigger,
            kind = vim.lsp.protocol.CompletionItemKind.Snippet,
            insertText = snippet.body,
            insertTextFormat = vim.lsp.protocol.InsertTextFormat.Snippet,
            documentation = {
              kind = vim.lsp.protocol.MarkupKind.Markdown,
              value = snippet.preview,
            },
          }
        end,

        M.current_buffer_snippets()

      )

      cache[bufnr] = completion_items

    end

    callback(cache[bufnr])

  end

  require('cmp').register_source('snippets', cmp_source)

end

return M
