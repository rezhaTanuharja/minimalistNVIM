---
-- @file lua/internal_plugins/snippets/init.lua
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

  lua = require('internal_plugins/snippets/lua'),
  python = require('internal_plugins/snippets/python'),

}

M.get_buf_snips = function()

  local filetype = vim.bo.filetype
  local snips = vim.list_slice(global_snippets)

  if filetype and snippets_by_filetype[filetype] then
    vim.list_extend(snips, snippets_by_filetype[filetype])
  end

  return snips

end

M.register_cmp_source = function()

  local cmp_source = {}
  local cache = {}

  function cmp_source.complete(_, _, callback)

    local bufnr = vim.api.nvim_get_current_buf()
    if not cache[bufnr] then

      local completion_items = vim.tbl_map(

        function(s)
          return {
            word = s.trigger,
            label = s.trigger,
            kind = vim.lsp.protocol.CompletionItemKind.Snippet,
            insertText = s.body,
            insertTextFormat = vim.lsp.protocol.InsertTextFormat.Snippet,
            documentation = {
              kind = vim.lsp.protocol.MarkupKind.Markdown,
              value = s.preview,
            },
          }
        end,

        M.get_buf_snips()

      )

      cache[bufnr] = completion_items

    end

    callback(cache[bufnr])

  end

  require('cmp').register_source('snippets', cmp_source)

end

return M
