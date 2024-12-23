---
-- @file projects/developers/lua/developers.lua
--
-- @brief
-- The plugin file for developers
--
-- @author Rezha Adrian Tanuharja
-- @date 2024-12-23
--


local languageservers = require('developers.languageservers')
local tests = require('developers.tests')
local codefixers = require('developers.codefixers')


local M = {}

function M.setup(opts)

  vim.api.nvim_create_augroup('LSP', { clear = true })
  vim.api.nvim_create_augroup('tests', { clear = true })
  vim.api.nvim_create_augroup('formatters', { clear = true })

  languageservers.setup(opts)

  for _, server in pairs(opts.servers) do
    languageservers.set_client(server)
  end

  for _, test in pairs(opts.tests) do
      tests.set_test(test)
  end

  for _, fixer in pairs(opts.codefixers) do
      codefixers.set_fixer(fixer)
  end

end

return M
