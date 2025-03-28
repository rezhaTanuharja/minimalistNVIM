return {

  filetypes = {"c", "cpp"},

  cmd = {"clangd", "--background-index", "--clang-tidy", "--log=verbose"},

  root_markers = { ".git", "compile_commands.json" },

  init_options = {
    fallbackFlag = {"-std=c++17"},
  },

  settings = {},

}
