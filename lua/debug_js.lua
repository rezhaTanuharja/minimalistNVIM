---
-- @file lua/debug_js.lua
--
-- @brief
-- The module file for debug_js
--
-- @author Tanuharja, R.A.
-- @date 2025-07-28
--

local M = {}

local dap_adapter = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    args = {
      vim.fn.stdpath("data") .. "/site/pack/plugins/opt/vscode-js-debug/dist/src/dapDebugServer.js",
      "${port}",
    },
  },
}

local dap_configs = {
  {
    type = "pwa-node",
    request = "launch",
    name = "[JS/TS] Launch file using node",
    program = "${file}",
    cwd = "${workspaceFolder}",
  },
  {
    type = "pwa-node",
    request = "attach",
    name = "[JS/TS] Attach to a process using node",
    processId = require("dap.utils").pick_process,
    cwd = "${workspaceFolder}",
  },
  {
    type = "pwa-chrome",
    request = "launch",
    name = "[JS/TS] Launch using Chrome",
    url = function()
      vim.cmd("redraw")
      return vim.fn.input("URL: ", "http://localhost:3000")
    end,
    webRoot = "${workspaceFolder}",
    sourceMaps = true,
  },
  {
    type = "pwa-chrome",
    request = "launch",
    name = "[JS/TS] Launch Using Brave",
    url = function()
      vim.cmd("redraw")
      return vim.fn.input("URL: ", "http://localhost:3000")
    end,
    webRoot = "${workspaceFolder}",
    sourceMaps = true,
    runtimeExecutable = "/Applications/Brave Browser.app/Contents/MacOS/Brave Browser",
  },
}

M.setup = function()
  local success, dap = pcall(require, "dap")
  if not success then
    vim.notify("failed to load a plugin: dap")
    return true
  end

  dap.adapters["pwa-node"] = dap_adapter
  dap.adapters["pwa-chrome"] = dap_adapter

  dap.configurations["typescript"] = dap_configs
  dap.configurations["javascript"] = dap_configs
  dap.configurations["typescriptreact"] = dap_configs
  dap.configurations["javascriptreact"] = dap_configs
end

return M
