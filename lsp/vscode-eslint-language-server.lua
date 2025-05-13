
return {

  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },

  cmd = {"vscode-eslint-language-server", "--stdio"},

  root_markers = { ".git", "package.json" },

  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePost", {
      buffer = bufnr,
      command = "silent !npx prettier % --write",
    })
  end,

  settings = {
    codeAction = {
      disableRuleComment = {
        enable = true,
        location = "separateLine"
      },
      showDocumentation = {
        enable = true
      }
    },
    codeActionOnSave = {
      enable = false,
      mode = "all"
    },
    experimental = {
      useFlatConfig = false
    },
    format = true,
    nodePath = "",
    onIgnoredFiles = "off",
    problems = {
      shortenToSingleLine = false
    },
    quiet = false,
    rulesCustomizations = {},
    run = "onType",
    useESLintClass = false,
    validate = "on",
    workingDirectory = {
      mode = "location"
    }
  },

}
