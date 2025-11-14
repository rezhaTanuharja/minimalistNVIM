---
-- @file after/ftplugin/cpp.lua
--
-- @brief
-- C++ - specific config
--
-- @author Tanuharja, R.A.
-- @date 2025-03-28
--

--
-- Sets up development environment for cpp.
--
-- + uses a global flag _G.cpp_env_set to set only once per session.
-- + checks if the language server is installed before enabling.
-- + set adapters and configurations for DAP.
--
_G.cpp_env_set = _G.cpp_env_set
  or (function()
    if vim.fn.executable("clangd") == 1 then
      vim.lsp.enable("clangd")
    end

    local success, dap = pcall(require, "dap")
    if not success then
      vim.notify("failed to load a plugin: dap")
      return true
    end

    dap.adapters.cpp = {
      type = "executable",
      command = "lldb-dap",
      name = "lldb",
    }

    dap.configurations.cpp = {
      {
        name = "[CPP] Launch LLDB",
        type = "cpp",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},
        runInTerminal = false,
      },
    }

    return true
  end)()
