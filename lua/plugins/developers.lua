---
-- @file lua/plugins/developers.lua
--
-- @brief
-- The configuration file for the plugin developers
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-12-07
--


local opts = {

  keymaps = {},
  hover = {},
  signatureHelp = {},
  language = {},

}

opts.keymaps = {

  definition  = 'gd',
  references  = 'gr',
  rename      = 'grn',

  deep_search = 'gs',
  refresh     = 'gn',

}

opts.hover = {
  title = ' Language Server ',
  border = 'single',
  wrap = true,
  wrap_at = 80,
  focus = false,
}

opts.signatureHelp = {
  title = ' Language Server ',
  border = 'single',
  focusable = false,
  wrap = true,
  wrap_at = 80,
}

opts.servers = {

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

}

opts.tests = {

  {
    executable = 'pytest',
    pattern = 'python',
    makeprg = 'pytest \\| tee log \\| grep "Error$"',
    errorformat = '%f:%l: %m',
  },

}

opts.codefixers = {

  {
    executable = 'ruff',
    pattern = '*.py',
    actions = {
      'silent! !ruff check --fix %',
      'silent! !ruff format %',
    },
  },

}

return {

  'developers', dev = true,

  event = 'UIEnter',

  opts = opts,

}
