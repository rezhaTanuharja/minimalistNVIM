---
-- @file after/ftplugin/javascriptreact.lua
--
-- @brief
-- Javascriptreact - specific config
--
-- @author Tanuharja, R.A.
-- @date 2025-07-26
--

--
-- Sets up development environment for JS, TS, JSX, and TSX.
--
-- + uses a global flag _G.jsx_tsx_env_set to set only once per session.
-- + checks if the language server is installed before enabling.
-- + set adapters and configurations for DAP.
--
_G.jsx_tsx_env_set = _G.jsx_tsx_env_set or (function()

  if vim.fn.executable("typescript-language-server") == 1 then
    vim.lsp.enable("typescript-language-server")
  end

  if vim.fn.executable("vscode-eslint-language-server") == 1 then
    vim.lsp.enable("vscode-eslint-language-server")
  end

  local success, jsdebug = pcall(require, "jsdebug")
  if not success then
    vim.notify("missing module: jsdebug")
    return true
  end

  jsdebug.setup()

  return true

end)()


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
