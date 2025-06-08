---
-- @file projects/textobjects/lua/textobjects.lua
--
-- @brief
-- The plugin file for textobjects
--
-- @author Tanuharja, R.A.
-- @date 2025-06-08
--


local M = {}


M.cache = {
  parent_node = nil,
  child_index = -1,
}


M.get_node = function(node_type)
  local node = vim.treesitter.get_node()

  local max_upward_steps = 16
  local upward_steps = 0

  while true do

    if upward_steps >= max_upward_steps then
      return nil
    end

    if not node then
      return nil
    end

    if node:type() == node_type then
      return node
    end

    node = node:parent()
    upward_steps = upward_steps + 1

  end
end


M.get_field = function(node, field_name)
  if not node then
    return nil
  end

  return node:field(field_name)
end


M.goto_node = function(node)
  if not node then
    return
  end

  local row, col, _, _ = node:range()
  vim.api.nvim_win_set_cursor(0, {row + 1, col})
end


M.get_next_child = function(parent_node)
  if not parent_node or parent_node:named_child_count() == 0 then
    return nil
  end

  if not M.cache.parent_node or M.cache.parent_node ~= parent_node then
    M.cache.parent_node = parent_node
    M.cache.child_index = -1
  end

  M.cache.child_index = M.cache.child_index + 1

  if M.cache.child_index >= M.cache.parent_node:named_child_count() then
    M.cache.child_index = 0
  end

  return M.cache.parent_node:named_child(M.cache.child_index)
end


M.yank_node = function(node)
  if not node then
    return
  end

  local start_row, _, end_row, _ = node:range()

  local lines = vim.api.nvim_buf_get_lines(0, start_row, end_row + 1, false)
  vim.fn.setreg('+', table.concat(lines, '\n'), 'V')
end


M.delete_node = function(node)
  if not node then
    return
  end

  local start_row, _, end_row, _ = node:range()

  vim.api.nvim_buf_set_lines(0, start_row, end_row + 1, false, {})

  local cursor_location = math.min(
    start_row + 1,
    vim.api.nvim_buf_line_count(0)
  )

  vim.api.nvim_win_set_cursor(0, {cursor_location, 0})
end


M.setup = function(opts)
end


return M
