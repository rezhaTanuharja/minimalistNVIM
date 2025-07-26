return {

  "microsoft/vscode-js-debug",

  build = "npm install --legacy-peer-deps --no-save && npx gulp dapDebugServer",
  version = "1.*",

  ft = {
    "javascript",
    "typescript",
    "javascriptreact",
    "typescriptreact",
  },

}
