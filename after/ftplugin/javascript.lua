---
-- @file after/ftplugin/javascript.lua
--
-- @brief
-- Javascript - specific config
--
-- @author Tanuharja, R.A.
-- @date 2025-06-21
--


local success, textobj = pcall(require, "textobjects")
if not success then
  vim.notify("failed to load a plugin: textobjects")
  return
end


vim.keymap.set(
  "n", "die",
  function()
    local jsx_element = textobj.get_node("jsx_element")
    textobj.yank_node(jsx_element)
    textobj.delete_node(jsx_element)
  end,
  { 
    desc = "delete a jsx element",
    buffer = true
  }
)


vim.keymap.set(
  "n", "yie",
  function()
    local jsx_element = textobj.get_node("jsx_element")
    textobj.yank_node(jsx_element)
  end,
  { 
    desc = "yank a jsx element",
    buffer = true
  }
)
