---
-- @file lua/plugins/init.lua
-- The initialization file to load external plugins
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-08-31
--


local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

-- install lazy from github repository if it is not installed
if not (vim.uv or vim.loop).fs_stat(lazypath) then

  -- github repository for lazy
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'

  -- command to clone repository
  local out = vim.fn.system({
    'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath
  })

  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end

end

vim.opt.rtp:prepend(lazypath)

-- use protected call to load lazy
local success, lazy = pcall(require, 'lazy')
if not success then
  vim.notify('Failed to load plugin: lazy')
  return
end

-- all plugin settings are in this directory
local location = 'plugins.'

-- specify manually the plugins to load
lazy.setup {

  lockfile = nil,

  rocks = {
    enabled = false,
    hererocks = false,
  },

  ui = {
    border = 'single',
    icons = {
      cmd = '',
      config = '',
      event = '',
      favorite = '',
      ft = '',
      init = '',
      import = '',
      keys = '',
      lazy = '',
      loaded = '●',
      not_loaded = "○",
      plugin = "",
      runtime = "",
      require = "",
      source = "",
      start = "",
      task = "✔ ",
      list = {
        "●",
        "➜",
        "★",
        "‒",
      },
    },
  },

  change_detection = {
    enabled = false,
    notify = false,
  },

  performance = {

    cache = {
      enabled = true,
    },

    reset_packpath = true,

    rtp = {
      reset = true,
      disabled_plugins = {
        'editorconfig',
        'gzip',
        'man',
        'matchit',
        'netrwPlugin',
        'rplugin',
        'spellfile',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },

  },

  spec = {

    { import = location .. 'blink' },
    { import = location .. 'fzf' },
    { import = location .. 'telescope' },
    { import = location .. 'gitsigns' },
    { import = location .. 'autopairs' },
    { import = location .. 'treesitter' },
    { import = location .. 'bbye' },
    { import = location .. 'blankline' },
    { import = location .. 'nvim-tree' },
    { import = location .. 'nvim-dap' },

    { import = location .. 'statusline' },
    { import = location .. 'prompt' },
    { import = location .. 'languageservers' },
    { import = location .. 'tests' },
    { import = location .. 'formatters' },
  },

  install = { colorscheme = { 'default' } },
}
