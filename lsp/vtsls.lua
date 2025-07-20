local vue_language_server_path = '/opt/homebrew/lib/node_modules/@vue/language-server'

local vue_plugin = {
  name = '@vue/typescript-plugin',
  location = vue_language_server_path,
  languages = { 'vue' },
  configNamespace = 'typescript',
}

return {

  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },

  cmd = { "vtsls", "--stdio" },

  root_markers = { "tsconfig.json", "package.json", "jsconfig.json", ".git" },

  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          vue_plugin,
        },
      },
    },
  },

}
