---
-- @file lua/plugins/developers/init.lua
--
-- @brief
-- The configuration file for the plugin developers
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-12-07
--


local opts = {}

opts.servers    = require('plugins.developers.languageservers')
opts.tests      = require('plugins.developers.tests')
opts.codefixers = require('plugins.developers.codefixers')

opts.keymaps = {

  definition  = 'gd',
  references  = 'gr',
  rename      = 'grr',

  code_action = 'ga',

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

return {

  'developers', dev = true,

  event = 'UIEnter',
  opts = opts,

}
