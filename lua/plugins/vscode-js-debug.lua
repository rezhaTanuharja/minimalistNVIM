---
-- @file lua/plugins/vscode-js-debug.lua
--
-- @brief
-- The configuration file for the vscode-js-debug
--
-- @author Tanuharja, R.A.
-- @date 2025-08-29
--

return {

  "microsoft/vscode-js-debug",

  build = {
    "sh",
    "-c",
    "npm install --legacy-peer-deps --no-save --ignore-scripts && npx gulp dapDebugServer",
  },
}
