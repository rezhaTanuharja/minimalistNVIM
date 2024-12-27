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
    name = 'clangd',
    executable = 'clangd',
    pattern = 'cpp',
    cmd = { 'clangd', '--background-index' },

    root_dir = function(buffer)
      return vim.fs.root(buffer, {'.git', 'compile_commands.json'})
    end,

    settings = {},

  },

  {
    name = 'tsls',
    executable = 'tsserver',
    pattern = 'javascript',
    cmd = { 'typescript-language-server', '--stdio' },

    root_dir = function(buffer)
      return vim.fs.root(buffer, {'.git', 'package.json'})
    end,

    settings = {},

  },

}
