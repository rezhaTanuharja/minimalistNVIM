---
-- @file lua/plugins/developers/languageservers.lua
--
-- @brief
-- The configuration file for the plugin developers: languageservers
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-12-20
--


return {

  {
    name = 'pyright',
    executable = 'pyright',
    pattern = 'python',
    cmd = {'pyright-langserver', '--stdio'},

    root_dir = function(buffer)
      return vim.fs.root(buffer, {'.git', 'pyproject.toml'})
    end,

    settings = {
      python = {
        analysis = {
          typeCheckingMode = 'basic',
          autoSeachPaths = true,
          indexing = true,
        }
      },
    },

    deep_search = {

      keymap = 'gs',
      formatter = function(identifier)
        return '\\(def\\|class\\) ' .. identifier
      end,

      extension = 'py',

    },
  },

  {
    name = 'ruff',
    executable = 'ruff',
    pattern = 'python',
    cmd = { 'ruff', 'server' },

    root_dir = function(buffer)
      return vim.fs.root(buffer, {'.git', 'pyproject.toml'})
    end,

    settings = {},

  },

  {
    name = 'tsls',
    executable = 'typescript-language-server',
    pattern = {'typescript', 'typescriptreact'},
    cmd = { 'typescript-language-server', '--stdio' },

    root_dir = function(buffer)
      return vim.fs.root(buffer, {'.git', 'tsconfig.json'})
    end,

    settings = {},

  },

  {
    name = 'texlab',
    executable = 'texlab',
    pattern = { 'tex', 'plaintex', 'bib' },
    cmd = { 'texlab' },

    root_dir = function(buffer)
      return vim.fs.root(buffer, {'.git', 'main.tex'})
    end,

    settings = {

      texlab = {

        bibtexFormatter = 'texlab',

        build = {
          onSave = false,
          onType = false,
        },

        diagnosticDelay = 100,
        formatterLineLength = 80,

        forwardSearch = {
          args = {},
        },

      }

    },

    single_file_support = true,

  },

}
