local function get_node(node_type)
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

local function get_field(node_type, field_name)
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
      break
    end

    node = node:parent()
    upward_steps = upward_steps + 1

  end

  return node:field(field_name)[1]
end

local function goto_node(node)
  if not node then
    return
  end

  local row, col, _, _ = node:range()
  vim.api.nvim_win_set_cursor(0, {row + 1, col})
end

local function yank_node(node)
  if not node then
    return
  end

  local start_row, _, end_row, _ = node:range()

  local lines = vim.api.nvim_buf_get_lines(0, start_row, end_row + 1, false)
  vim.fn.setreg('+', table.concat(lines, '\n'))
end

local function delete_node(node)
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

vim.keymap.set(
  "n", "dif",
  function()
    local function_definition = get_node("function_definition")
    yank_node(function_definition)
    delete_node(function_definition)
  end,
  { buffer = true }
)

vim.keymap.set(
  "n", "dic",
  function()
    local class_definition = get_node("class_definition")
    yank_node(class_definition)
    delete_node(class_definition)
  end,
  { buffer = true }
)

vim.keymap.set(
  "n", "yif",
  function()
    local function_definition = get_node("function_definition")
    yank_node(function_definition)
  end,
  { buffer = true }
)

vim.keymap.set(
  "n", "yic",
  function()
    local class_definition = get_node("class_definition")
    yank_node(class_definition)
  end,
  { buffer = true }
)

vim.keymap.set(
  "n", "gfn",
  function()
    local function_name = get_field("function_definition", "name")
    goto_node(function_name)
  end,
  { buffer = true }
)

vim.keymap.set(
  "n", "gcn",
  function()
    local class_name = get_field("class_definition", "name")
    goto_node(class_name)
  end,
  { buffer = true }
)

local cache = {
  parent_node = nil,
  child_index = -1,
}

local function get_next_child(parent_node)
  if not parent_node then
    return nil
  end
  if not cache.parent_node or cache.parent_node ~= parent_node then
    cache.parent_node = parent_node
    cache.child_index = -1
  end
  cache.child_index = cache.child_index + 1
  if cache.child_index >= cache.parent_node:named_child_count() then
    cache.child_index = 0
  end
  return cache.parent_node:named_child(cache.child_index)
end

vim.keymap.set(
  "n", "gfp",
  function()
    local function_parameters = get_field("function_definition", "parameters")
    local parameter = get_next_child(function_parameters)
    goto_node(parameter)
  end,
  { buffer = true }
)
