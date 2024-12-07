local languageservers = require('developers.languageservers')
local tests = require('developers.tests')
local codefixers = require('developers.codefixers')


local M = {}

function M.setup(opts)

  vim.api.nvim_create_augroup('LSP', { clear = true })
  vim.api.nvim_create_augroup('tests', { clear = true })
  vim.api.nvim_create_augroup('formatters', { clear = true })

  languageservers.setup(opts)

  for language, settings in pairs(opts.language) do

    if settings.languageserver then
      languageservers.create_autocmd( settings.languageserver )
    end

    if settings.test then
      tests.create_autocmd( settings.test )
    end

    if settings.codefixer then
      codefixers.create_autocmd( settings.codefixer )
    end

  end

end

return M
