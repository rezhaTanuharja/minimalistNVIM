---
-- @file after/ftplugin/go.lua
--
-- @brief
-- Go - specific config
--
-- @author Tanuharja, R.A.
-- @date 2025-07-25
--

--
-- Sets up development environment for Go.
--
-- + uses a global flag _G.go_env_set to set only once per session.
-- + checks if the language server is installed before enabling.
--
_G.go_env_set = _G.go_env_set or (function()

  if vim.fn.executable("gopls") == 1 then
    vim.lsp.enable("gopls")
  end

  return true

end)()
