---
-- @file after/ftplugin/rust.lua
--
-- @brief
-- Rust - specific config
--
-- @author Tanuharja, R.A.
-- @date 2025-08-10
--

--
-- Sets up development environment for Rust.
--
-- + uses a global flag _G.rust_env_set to set only once per session.
-- + checks if the language server is installed before enabling.
--
_G.rust_env_set = _G.rust_env_set
  or (function()
    if vim.fn.executable("rust-analyzer") == 1 then
      vim.lsp.enable("rust-analyzer")
    end
    return true
  end)()
