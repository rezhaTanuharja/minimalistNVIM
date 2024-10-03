---
-- @file lua/external_plugins/treesitter.lua
--
-- @brief
-- The configuration file for the plugin treesitter
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-08-31
--


return {

  'nvim-treesitter/nvim-treesitter',

  event = {'BufReadPost', 'BufNewFile'},

  build = ':TSUpdate',
  main = 'nvim-treesitter.configs',

  config = function()

    local success, treesitter = pcall(require, 'nvim-treesitter.configs')
    if not success then
      vim.notify('Failed to load plugin: treesitter')
      return
    end

    treesitter.setup {
      ensure_installed = { 'python', 'latex' },
      sync_install = true,
      ignore_install = {},
      highlight = {
        enable = true,
        disable = { 'markdown' },
      },
      indent = { enable = true, disable = { 'css', 'latex' }},
      fold = { enable = true },
    }

    vim.o.foldmethod = 'expr'
    vim.o.foldexpr = 'nvim_treesitter#foldexpr()'

  end,

}
