---
-- @file after/ftplugin/python.lua
--
-- @brief
-- Python - specific config
--
-- @author Tanuharja, R.A.
-- @date 2025-06-08
--


local success, textobj = pcall(require, "textobjects")
if not success then
  vim.notify("failed to load a plugin: textobjects")
  return
end


vim.keymap.set(
  "n", "dif",
  function()
    local function_definition = textobj.get_node("function_definition")
    textobj.yank_node(function_definition)
    textobj.delete_node(function_definition)
  end,
  { 
    desc = "delete a function definition",
    buffer = true
  }
)


vim.keymap.set(
  "n", "dic",
  function()
    local class_definition = textobj.get_node("class_definition")
    textobj.yank_node(class_definition)
    textobj.delete_node(class_definition)
  end,
  { 
    desc = "delete a class definition",
    buffer = true
  }
)


vim.keymap.set(
  "n", "yif",
  function()
    local function_definition = textobj.get_node("function_definition")
    textobj.yank_node(function_definition)
  end,
  { 
    desc = "yank a function definition",
    buffer = true
  }
)


vim.keymap.set(
  "n", "yic",
  function()
    local class_definition = textobj.get_node("class_definition")
    textobj.yank_node(class_definition)
  end,
  { 
    desc = "yank a class definition",
    buffer = true
  }
)


vim.keymap.set(
  "n", "gfn",
  function()
    local function_definition = textobj.get_node("function_definition")
    local name_fields = textobj.get_field(function_definition, "name")
    
    if not name_fields or #name_fields < 1 then
      return
    end

    textobj.goto_node(name_fields[1])
  end,
  { 
    desc = "jump to function name",
    buffer = true
  }
)


vim.keymap.set(
  "n", "gcn",
  function()
    local class_definition = textobj.get_node("class_definition")
    local name_fields = textobj.get_field(class_definition, "name")

    if not name_fields or #name_fields < 1 then
      return
    end

    textobj.goto_node(name_fields[1])
  end,
  { 
    desc = "jump to class name",
    buffer = true
  }
)


vim.keymap.set(
  "n", "gfp",
  function()
    local function_definition = textobj.get_node("function_definition")
    local parameters = textobj.get_field(function_definition, "parameters")

    if not parameters or #parameters < 1 then
      return
    end

    local parameter = textobj.get_next_child(parameters[1])

    textobj.goto_node(parameter)
  end,
  { 
    desc = "jump to function parameters (cyclic)",
    buffer = true
  }
)
