return {

	"microsoft/vscode-js-debug",

  build = {
    "sh", "-c",
    "npm install --legacy-peer-deps --no-save && npx gulp dapDebugServer",
  },
}
