---
-- @file lua/profiles/rezha/plugins/luasnip.lua
--
-- @brief
-- The configuration file for the plugin luasnip
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-08-31
--


return {

  'L3MON4D3/LuaSnip',

  lazy = true,

  -- use regex but it is not available in windows and requires make
  build = (
    function()
      if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
        return
      end
      return 'make install_jsregexp'
    end
  )(),

  dependencies = {},

  config = function()
    -- automatically load snippets in the shared directory
    require('luasnip.loaders.from_lua').lazy_load({
      paths = './lua/shared/snippets'
    })
  end,

}
