---
-- @file lua/plugins/languageservers.lua
--
-- @brief
-- The file to set options for Neovim's builtin LSP capabilities
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-12-01
--


local opts = {}


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


opts.language_config = {


  python = {

    cmd = {'pyright-langserver', '--stdio'},

    root_dir = function(buffer)
      return vim.fs.root(buffer, {'pyproject.toml'})
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

      formatter = function(identifier)
        return '\\(def\\|class\\) ' .. identifier
      end,

      extension = 'py',

    },

  },


  lua = {

    cmd = {'lua-language-server'},

    root_dir = function(buffer)
      return vim.fs.root(buffer, {'.git'})
    end,

    settings = {
      Lua = {
        runtime = { version = 'LuaJIT' },
        diagnostics = { globals = {'vim'} },
      },
    },

    deep_search = {

      formatter = function(identifier)
        return identifier
      end,

      extension = 'lua',

    },

  },


  cpp = {

    cmd = {'clangd', '--background-index'},

    root_dir = function(buffer)
      return vim.fs.root(buffer, {'compile_commands.json'})
    end,

    settings = {},

    deep_search = {

      formatter = function(identifier)
        return identifier
      end,

      extension = '*pp',

    },

  },


}


return {

  dir = vim.fn.stdpath('config') .. '/projects/languageservers.lua',

  event = 'UIEnter',

  config = function()
    require('languageservers').setup(opts)
  end

}
