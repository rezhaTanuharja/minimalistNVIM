---
-- @file projects/developers/lua/developers/languageservers.lua
--
-- @brief
-- The plugin file for developers - languageservers
--
-- @author Tanuharja, R.A.
-- @date 2024-12-23
--


local M = {}

-- used if buffer root directory cannot be found
function M.dir_fallback(buffer)
  return vim.fn.fnamemodify(buffer, ":p:h")
end

-- refresh all buffer while preserving the current layout
function M.refresh()

  vim.lsp.stop_client(vim.lsp.get_clients(), true)

  vim.defer_fn(
    function()
      local window_buffer_map = {}
      for _, window_id in pairs(vim.api.nvim_tabpage_list_wins(0)) do
        local buffer_id = vim.api.nvim_win_get_buf(window_id)
        table.insert(window_buffer_map, { window_id = window_id, buffer_id = buffer_id})
      end

      if #window_buffer_map > 0 then
        vim.cmd("bufdo if &modifiable | write | edit | endif")
      end

      for _, entry in pairs(window_buffer_map) do
        vim.api.nvim_win_set_buf(entry.window_id, entry.buffer_id)
      end
    end,
    100
  )

end

-- similar to goto definitions but search any words in the root directory
function M.deep_search(formatter, extension)

  local buf_number = vim.api.nvim_get_current_buf()

  local success, active_clients = pcall(vim.lsp.get_clients, { bufnr = buf_number })
  if not success then
    print("There is no active client")
    return
  end

  local root_dir = active_clients[1].workspace_folders[1].name
  local search_term = formatter(vim.fn.expand("<cword>"))

  vim.cmd("vimgrep /" .. search_term .. "/ " .. root_dir .. "/**/*." .. extension )
  vim.cmd("copen")

end

function M.setup(opts)

  vim.keymap.set("n", opts.keymaps.refresh, M.refresh)

end

return M
