return {

  filetypes = { "python" },

  cmd = {"pyright-langserver", "--stdio"},

  root_markers = { ".git", "pyproject.toml" },

  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
        autoSeachPaths = true,
        indexing = true,
      }
    },
  },

}
